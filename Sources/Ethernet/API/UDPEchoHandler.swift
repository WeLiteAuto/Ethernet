//
// Created by Aaron Ge on 2023/4/20.
//

import Foundation
import NIO

final class UDPEchoHandler: ChannelInboundHandler {
    public typealias InboundIn = AddressedEnvelope<ByteBuffer>

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let envelope = unwrapInboundIn(data)
        let byteBuffer = envelope.data
        if let response = byteBuffer.getString(at: byteBuffer.readerIndex, length: byteBuffer.readableBytes) {
            print("response: \(response)")
        }

        context.close(promise: nil)
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: \(error)")
        context.close(promise: nil)
    }
}
