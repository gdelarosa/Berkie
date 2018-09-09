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
    
    static func signUp(username: String, email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let result = user else {
                return
            }
            let uid = result.user.uid
            
//            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid)
//
//            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
//                if error != nil {
//                    return
//                }
            
//                storageRef.downloadURL(completion: { (url, error) in
//                    if let profileImageUrl = url?.absoluteString {
//                        self.setUserInfomation(profileImageUrl: profileImageUrl, username: username, email: email, uid: uid, onSuccess: onSuccess)
//                    }
//                })
           
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
