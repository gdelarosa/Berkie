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
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        returnToLogin.layer.masksToBounds = true
        returnToLogin.layer.cornerRadius = returnToLogin.frame.width/2
        returnToLogin.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        signUpButton.layer.cornerRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func closeAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        AuthService.signUp(email: emailTextfield.text!, password: passwordTextfield.text!, onSuccess: {

            let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let navigationControlr = UINavigationController(rootViewController: homeController)
            self.present(navigationControlr, animated: true, completion: nil)
            
            }, onError: { (errorString) in
               self.alert(message: "Please enter valid email address", title: "Invalid Email")
            })
    }
    

}
