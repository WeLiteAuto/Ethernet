//
// Created by Aaron Ge on 2023/4/20.
//

import Foundation
import NIO

/// A class that implements the TCP protocol.
final class TCPEchoHandler : ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let byteBuffer = self.unwrapInboundIn(data)
        let message = byteBuffer.getString(at: byteBuffer.readerIndex, length: byteBuffer.readableBytes)
        print("Received message from server: \(String(describing: message!))")
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: \(error)")
        context.close(promise: nil)
    }
}
