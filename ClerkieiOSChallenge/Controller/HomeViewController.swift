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
import RHSideButtons
import PopupDialog
import Photos
import MobileCoreServices

class HomeViewController: BaseChatViewController {
    
    var currtxt = ""
    var buttonsArray = [RHButtonView]()
    
    var messageSender = DemoChatMessageSender()
    let messagesSelector = BaseMessagesSelector()
    var dataSource = DemoChatDataSource(count: 0, pageSize: 500)
    
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender, messagesSelector: self.messagesSelector)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetups()
        setupSideMenu()
        self.view.backgroundColor = .white
      
        self.messagesSelector.delegate = self as MessagesSelectorDelegate
        self.chatItemsDecorator = DemoChatItemsDecorator(messagesSelector: self.messagesSelector)
        
        self.messageSender = self.dataSource.messageSender
        self.chatDataSource = self.dataSource
        self.dataSource.addIntroMessage("Hello! Welcome to Berkie, the app for your financial success and well being. How do you feel about your finances at this moment? Please enter: [Great, Meh, or Bad]")
    }
    
    // MARK: - Setup for side menu
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        castView().sideButtonsView?.reloadButtons()
    }
    
    override func loadView() {
        view = SideButtonView()
    }
    
    func castView() -> SideButtonView {
        return view as! SideButtonView
    }
    
    fileprivate func setupSideMenu() {
        addSideButtons()
    }
    
    fileprivate func addSideButtons() {
        
        let triggerButton = RHTriggerButtonView(pressedImage: UIImage(named: "exit_icon")!) {
            $0.image = UIImage(named: "trigger_img")
            $0.hasShadow = true
        }
        
        let sideButtonsView = RHSideButtons(parentView: castView(), triggerButton: triggerButton)
        sideButtonsView.delegate = self
        sideButtonsView.dataSource = self
        
        for index in 1...4 {
            buttonsArray.append(generateButton(withImgName: "icon_\(index)"))
        }
        
        castView().set(sideButtonsView: sideButtonsView)
        castView().sideButtonsView?.reloadButtons()
    }
    
    fileprivate func generateButton(withImgName imgName: String) -> RHButtonView {
        
        return RHButtonView {
            $0.image = UIImage(named: imgName)
            $0.hasShadow = true
        }
    }
    
    // MARK: - Navigation Bar Setup
    func navBarSetups() {
        navBarSetup()
        
        // Right Bar Button
        let graphsButton = UIBarButtonItem(image: UIImage(named: "Chart-6"), style: .plain, target: self, action: #selector(goToGraphsAction))
        self.navigationItem.rightBarButtonItem  = graphsButton
        graphsButton.tintColor = UIColor.black
 
    }
    
    @objc func goToGraphsAction() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChartsViewController") as! ChartsViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    // MARK: Chatto Setup
    
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
            
    
            if(self?.currtxt.lowercased() == "great"){
                DemoChatMessageFactory.messageIndex = 2
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[2], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "meh") {
                DemoChatMessageFactory.messageIndex = 2
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[2], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "bad") {
                DemoChatMessageFactory.messageIndex = 2
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[2], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "hi") {
                DemoChatMessageFactory.messageIndex = 1
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[1], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "hey") {
                DemoChatMessageFactory.messageIndex = 1
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[1], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "no") {
                DemoChatMessageFactory.messageIndex = 4
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[4], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "yes") {
                DemoChatMessageFactory.messageIndex = 3
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[3], isIncoming: true)
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[7], isIncoming: true)
            }
            else if(self?.currtxt.lowercased() == "ok") {
                DemoChatMessageFactory.messageIndex = 6
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[0], isIncoming: true)
            }
            else{
                self?.dataSource.addTextMessage(DemoChatMessageFactory.demoText[0], isIncoming: true)
            }
        }
        return item
    }
    
}

// MARK: - Extensions
extension HomeViewController: MessagesSelectorDelegate {
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didSelectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
    
    func messagesSelector(_ messagesSelector: MessagesSelectorProtocol, didDeselectMessage: MessageModelProtocol) {
        self.enqueueModelUpdate(updateType: .normal)
    }
}

extension HomeViewController: RHSideButtonsDataSource {
    
    func sideButtonsNumberOfButtons(_ sideButtons: RHSideButtons) -> Int {
        return buttonsArray.count
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, buttonAtIndex index: Int) -> RHButtonView {
        return buttonsArray[index]
    }
}

extension HomeViewController: RHSideButtonsDelegate {
    
    func sideButtons(_ sideButtons: RHSideButtons, didSelectButtonAtIndex index: Int) {
        
        if index == 0 || index == 1 || index == 2 {
            let title = "Your Money Your Rules"
            let message = "We can help with transferring money, depositing checks, and borrowing money. Right now our settings indicate you do not have of these features setup. Please visit the settings within the app to get started."
            let gifURL : String = "https://media.giphy.com/media/uFtywzELtkFzi/giphy.gif"
            let image = UIImage.gifImageWithURL(gifURL)
            let popup = PopupDialog(title: title, message: message, image: image)
            
            let buttonOne = CancelButton(title: "Sounds Great!") {
                print("Closed popup.")
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func sideButtons(_ sideButtons: RHSideButtons, didTriggerButtonChangeStateTo state: RHButtonState) {
        print("Trigger button")
    }
}


