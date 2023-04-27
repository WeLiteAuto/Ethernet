////
//// Created by Aaron Ge on 2023/4/20.
////
//
//import Foundation
//
//class UDPServer {
//    private let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
//    private var channel: Channel?
//
//    func start(host: String, port: Int) async throws {
//        let bootstrap = DatagramBootstrap(group: self.group)
//                .channelOption(ChannelOptions.socketOption(.reuseaddr), value: 1)
//                .channelInitializer { channel in
//                    channel.pipeline.addHandler(UDPEchoHandler())
//                }
//
//        self.channel = try await bootstrap.bind(host: host, port: port).get()
//    }
//
//    func stop() async throws {
//        try await self.channel?.close()
//        try await self.group.shutdownGracefully()
//    }
//}
