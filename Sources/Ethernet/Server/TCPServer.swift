//
// Created by Aaron Ge on 2023/4/20.
//

import Foundation
import NIO

class TCPServer {
    private let group =  MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    private var channel: Channel?

    public func start(on locationAddress: SocketAddress) async throws {
        let bootstrap = ServerBootstrap(group: self.group)
            .serverChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .childChannelInitializer { channel in
                channel.pipeline.addHandler(TCPEchoHandler())
            }
            .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 1)

        self.channel = try await bootstrap.bind(to: locationAddress).get()
        print("TCP server start on \(locationAddress.ipAddress!):\(locationAddress.port!)")
    }

    public func stop() async throws {
        try await self.channel?.close()
        try await self.group.shutdownGracefully()
    }



}
