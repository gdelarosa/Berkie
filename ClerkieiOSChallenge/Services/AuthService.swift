//
//  AuthService.swift
//  ClerkieiOSChallenge
//
//  Created by Gina De La Rosa on 9/9/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//  MARK: - Setup for signing in user, creating an account, and resetting password through Firebase

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
        })
        
    }

    static func resetPassword(email: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error != nil {
               onError(error!.localizedDescription)
            return
            }
            onSuccess()
        })
    }

}
