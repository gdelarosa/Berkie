//
//  AuthService.swift
//  ClerkieiOSChallenge
//
//  Created by Gina De La Rosa on 9/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthService {
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
        
    }
    
    static func signUp(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
            
//            guard let result = user else {
//                return
//            }
//            _ = result.user.uid
           
        })
        
    }
    
    static func resetPassword(email:String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("An email with information on how to Reset your password has been sent.")
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
//    static func forgotPasswordReset(email: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
//        
//        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
//        forgotPasswordAlert.addTextField { (textField) in
//            textField.placeholder = "Enter email address"
//        }
//        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
//        let resetEmail = forgotPasswordAlert.textFields?.first?.text
//
//        Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
//
//            DispatchQueue.main.async {
//
//                if let error = error {
//                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: error.localizedDescription, preferredStyle: .alert)
//                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                    self.present(resetFailedAlert, animated: true, completion: nil)
//                } else {
//                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
//                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                    self.present(resetEmailSentAlert, animated: true, completion: nil)
//                }
//            }
//        })
//
//           }
//      }
//  }

}
