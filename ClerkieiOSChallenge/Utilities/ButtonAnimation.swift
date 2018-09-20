//
//  ButtonAnimation.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/10/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func animatedButton(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.2,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)},
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                sender.transform = CGAffineTransform.identity })
        })
    }
    
    func addPulse() {
        let buttonPulse = CASpringAnimation(keyPath: "transform.scale")
        buttonPulse.duration = 0.3
        buttonPulse.fromValue = 0.95
        buttonPulse.toValue = 1.0
        buttonPulse.autoreverses = true
        buttonPulse.repeatCount = 2
        buttonPulse.initialVelocity = 0.5
        buttonPulse.damping = 1.0
        
        layer.add(buttonPulse, forKey: "pulse")
    }
    
    func errorshake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}
