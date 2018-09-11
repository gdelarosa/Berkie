//
//  HomeViewController.swift
//  ClerkieiOSChallenge
//
//  Created by Gina De La Rosa on 9/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  MARK: - This is the home view controller after the user logs in. Will be able to chat here.

import UIKit
import Chatto
import ChattoAdditions

class HomeViewController: BaseChatViewController {
    
    var currtxt = ""
    var whatIsUp = "what's up?"
    
    var messageSender = DemoChatMessageSender()
    let messagesSelector = BaseMessagesSelector()
    var dataSource = DemoChatDataSource(count: 0, pageSize: 500)
    
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender, messagesSelector: self.messagesSelector)
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = .white
      
        self.messagesSelector.delegate = self as MessagesSelectorDelegate
        self.chatItemsDecorator = DemoChatItemsDecorator(messagesSelector: self.messagesSelector)
        
        self.messageSender = self.dataSource.messageSender
        self.chatDataSource = self.dataSource
        self.dataSource.addIntroMessage("Hello! Welcome to Berkie, the app for your financial success and well being. How do you feel about your finances at this moment?")
    }
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: DemoTextMessageViewModelBuilder(),
            interactionHandler: DemoTextMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()
        
        let photoMessagePresenter = PhotoMessagePresenterBuilder(
            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
            interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
        )
        photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellAvatarStyle()
        
        return [
            DemoTextMessageModel.chatItemType: [textMessagePresenter],
            DemoPhotoMessageModel.chatItemType: [photoMessagePresenter],
            SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
            TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
        ]
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            self?.dataSource.addPhotoMessage(image)
        }
        return item
    }
    
    // MARK: - Chat
    private func createTextInputItem() -> TextChatInputItem {
        
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            self?.dataSource.addTextMessage(text, isIncoming: false)
            self?.currtxt = text
            
            //General
            if(self?.currtxt.lowercased() == "fine"){
                DemoChatMessageFactory.messageIndex = 2
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[2], isIncoming: true)
            }
            //Greetings
            else if(self?.currtxt.lowercased() == "hi") {
                DemoChatMessageFactory.messageIndex = 1
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[1], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "hey") {
                DemoChatMessageFactory.messageIndex = 1
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[1], isIncoming: true)
            }
            //
            else if(self?.currtxt.lowercased() == "no") {
                DemoChatMessageFactory.messageIndex = 0
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[0], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "ok") {
                DemoChatMessageFactory.messageIndex = 0
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[0], isIncoming: true)
            }
            else{
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[0], isIncoming: true)
            }
        }
        return item
    }
    
}

extension HomeViewController: MessagesSelectorDelegate {
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didSelectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
    
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didDeselectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
}


