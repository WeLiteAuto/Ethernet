import XCTest
import NIO
@testable import Ethernet


final class TCPTests: XCTestCase {

    private var group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var client: TCPClient?

    override func setUp() async throws{
        try await super.setUp()

        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        client = TCPClient(group: group, handler: TCPStatusHandler())
    }


    func testTCPClient() async throws{

        let message = "Hello TCP server!\n"
        guard let remoteAddress = try? SocketAddress(ipAddress: "192.168.50.179", port: 1234)
        else {
            fatalError("Unable to resolve address")
        }

        print("Try to send message to \(remoteAddress), with message: \(message)")

        
        try await client?.connect(to: remoteAddress)
        try await client?.send(message: message)
        

        for _ in 0...10000{

        }
        
        try await client?.stop()

    }

    override func tearDown() async throws {
        try await group.shutdownGracefully()
//        try await client?.stop()
        try await super.tearDown()
    }
}
