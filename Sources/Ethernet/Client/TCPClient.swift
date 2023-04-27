//
// Created by Aaron Ge on 2023/4/20.
import NIO

class TCPClient
{
    private let group : MultiThreadedEventLoopGroup
    private let handler: ChannelHandler?
    private var bootstrap: ClientBootstrap?
    private var channel: Channel?
    
    
    init(group: MultiThreadedEventLoopGroup, handler: ChannelHandler?=nil) {
        self.group = group
        self.handler = handler
    }
    
    /// connect to remote host
    /// - Parameter remoteAddress:
    /// - Throws:
    func connect(to remoteAddress: SocketAddress) async throws
    {
        bootstrap = ClientBootstrap(group: self.group)
            .channelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .channelOption(ChannelOptions.socket(SocketOptionLevel(IPPROTO_TCP), TCP_NODELAY), value: 1)
            .channelInitializer{ channel in
                channel.pipeline.addHandlers([self.handler ?? TCPEchoHandler(), TCPEchoHandler()])
            }
        
        channel = try await bootstrap!.connect(to: remoteAddress).get()
        
        guard channel != nil
        else{
            throw TCPError.ChannelError(reason: "no available channel")
        }
        print("Connect successed!")
       
        
        
        
    }
    
    ///
    ///
    /// - Parameter message:
    /// - Throws:
    func send(message: String) async throws
    {
        guard let channel = self.channel,
              channel.isActive
        else {
            throw TCPError.ChannelError(reason: "no available channel")
        }
        
        let data = ByteBuffer(string: message)
    
        try await channel.writeAndFlush(data).get()
    }
    
    func stop() async throws {
        try await  self.channel?.close()
    }
}
