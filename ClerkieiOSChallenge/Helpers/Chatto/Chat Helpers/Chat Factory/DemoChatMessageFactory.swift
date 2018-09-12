/*
 The MIT License (MIT)

 Copyright (c) 2015-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Modified by Gina De La Rosa on 9/11/18.
 Copyright © 2018 Gina De La Rosa. All rights reserved.
 This is where the bot's information is. 
*/



import Foundation
import Chatto
import ChattoAdditions

func makeTextMessage(_ uid: String, text: String, isIncoming: Bool) -> DemoTextMessageModel {
    let messageModel = makeMessageModel(uid, isIncoming: isIncoming, type: TextMessageModel<MessageModel>.chatItemType)
    let textMessageModel = DemoTextMessageModel(messageModel: messageModel, text: text)
    return textMessageModel
}

func makeMessageModel(_ uid: String, isIncoming: Bool, type: String) -> MessageModel {
    let senderId = isIncoming ? "1" : "2"
    return MessageModel(uid: uid, senderId: senderId, type: type, isIncoming: isIncoming, date: Date(), status: .success)
    
}

func makePhotoMessage(_ uid: String, image: UIImage, size: CGSize, isIncoming: Bool) -> DemoPhotoMessageModel {
    let messageModel = makeMessageModel(uid, isIncoming: isIncoming, type: PhotoMessageModel<MessageModel>.chatItemType)
    let photoMessageModel = DemoPhotoMessageModel(messageModel: messageModel, imageSize: size, image: image)
    return photoMessageModel
}

class DemoChatMessageFactory {
    static var messageIndex = 0
    
    private enum DemoMessage {
        case text(String)
        case image(String)
    }
    
     static let demoText =
        [
            "Apologies. I am not smart enough yet to understand what you sent. Please try something else.", //0
            "Hi! 👋", //1 GREETING
            "Thanks for sharing! Well I'm here to make your life easier. Are you interested?", //2
            //Yes
            "Awesome! 💰 There are many benefits with being mindful 🤓 of one's finances.", // 3
            //No
            "Sorry to hear that. 😔 I'm always here to help when you're ready.", //4
            "Based off my calculations, it appears that you're finances are looking healthy 💯. Remeber, if you have any questions don't hesitate to ask!", // 5
            "Let's talk getting financially healthy and happy sometime. 💰", //6
            "For the most part, I can answer questions on topics such as savings, 401k, taxes, and budgeting."//7
            
    ]
    
    class func makeChatItem(uid: String) -> MessageModelProtocol {
        return self.makeChatItem(uid: "3-\(index)", isIncoming: true)
    }
    
    class func makeChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
        return self.makeTextMessageModel(uid: "3-\(index)", isIncoming: isIncoming)
    }
    
    class func makeTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel<MessageModel> {
        let text = self.demoText[messageIndex]
        return makeTextMessage("3-\(index)", text: text, isIncoming: isIncoming)
    }
}

extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}

extension PhotoMessageModel {
    static var chatItemType: ChatItemType {
        return "photo"
    }
}
