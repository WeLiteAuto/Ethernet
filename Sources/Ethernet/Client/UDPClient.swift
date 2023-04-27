// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import NIO

/// A class that implements the UDP protocol.
class UDPClient{
    /// The channel handler
    private let handler: ChannelHandler?
    /// The event loop group
    private let group: MultiThreadedEventLoopGroup
    private var channel: Channel?
    

    init(group:MultiThreadedEventLoopGroup, handler: ChannelHandler? = nil) {
        self.group = group
        self.handler = handler

    }

    public func connect() async throws {

        let bootstrap = DatagramBootstrap(group: group)
                .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)

                .channelInitializer { channel in
                    channel.pipeline.addHandler(self.handler!)
                }

        channel =  try await bootstrap.bind(host: "0.0.0.0", port: 0).get()
        
    }


    public func send(to remoteAddress: SocketAddress, message: String) async throws {
    
        guard let ipAddress = remoteAddress.ipAddress,
              let port = remoteAddress.port
        else{
            throw fatalError("Error address")
        }
        let envelop = AddressedEnvelope(remoteAddress: remoteAddress,
                                        data: ByteBuffer(string: message))
        try await channel!.writeAndFlush(envelop).get()
        print("Echo client send to remote address \(ipAddress):\(port)")
    }

       
    

}
