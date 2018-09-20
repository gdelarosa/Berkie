//
//  Subclass.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/20/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import Foundation
import UIKit
import Chatto
import ChattoAdditions

class SubclassTextMessagePresenter<ViewModelBuilderT, InteractionHandlerT>: TextMessagePresenter<ViewModelBuilderT, InteractionHandlerT> where
    ViewModelBuilderT: ViewModelBuilderProtocol,
    ViewModelBuilderT.ViewModelT: TextMessageViewModelProtocol,
    InteractionHandlerT: BaseMessageInteractionHandlerProtocol,
InteractionHandlerT.ViewModelT == ViewModelBuilderT.ViewModelT {
    
    override func configureCell(_ cell: BaseMessageCollectionViewCell<TextBubbleView>,
                                decorationAttributes: ChatItemDecorationAttributes,
                                animated: Bool,
                                additionalConfiguration: (() -> Void)?) {
        super.configureCell(cell, decorationAttributes: decorationAttributes, animated: animated) {
            if self.messageModel.isIncoming {
                self.messageViewModel.avatarImage.value = UIImage(named: "icon_1")
            } else {
                self.messageViewModel.avatarImage.value = UIImage(named: "icon_2")
            }
            additionalConfiguration?()
        }
    }
}
