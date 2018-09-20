//
//  MainView.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.

//  MARK: - Used with the RHSideButtons CocoaPod as helper.

import UIKit
import RHSideButtons

class SideButtonView: UIView {
    
    fileprivate let triggerButtonMargin = CGFloat(85)
    
    var sideButtonsView: RHSideButtons?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout Buttons
        sideButtonsView?.setTriggerButtonPosition(CGPoint(x: bounds.width - 60, y: bounds.height - 160))
    }
    
    fileprivate func setup() {
        backgroundColor = UIColor.lightGray
    }
    
    func set(sideButtonsView view: RHSideButtons) {
        sideButtonsView = view
    }
}
