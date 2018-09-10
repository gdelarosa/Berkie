//
//  SignUpViewController.swift
//  Berkie
//
//  Created by Gina De La Rosa on 9/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var returnToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnToLogin.layer.masksToBounds = true
        returnToLogin.layer.cornerRadius = returnToLogin.frame.width/2 
        returnToLogin.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
    }

    @IBAction func closeAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    


}
