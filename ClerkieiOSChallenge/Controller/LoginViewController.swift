//
//  LoginViewController.swift
//  LoginCritter
//
//  Created by Christopher Goldsby on 3/30/18.
//  Copyright © 2018 Christopher Goldsby. All rights reserved.
//
//
//  LoginViewController.swift
//  ClerkieiOSChallenge
//
//  Created by Gina De La Rosa on 09/09/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

import UIKit
import Firebase
import BubbleTransition

private let buttonFrame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
private let buttonHeight = textFieldHeight
private let buttonHorizontalMargin = textFieldHorizontalMargin / 2
private let buttonImageDimension: CGFloat = 18
private let buttonVerticalMargin = (buttonHeight - buttonImageDimension) / 2
private let buttonWidth = (textFieldHorizontalMargin / 2) + buttonImageDimension

private let critterViewDimension: CGFloat = 160
private let critterViewFrame = CGRect(x: 0, y: 0, width: critterViewDimension, height: critterViewDimension)
private let critterViewTopMargin: CGFloat = 70

private let textFieldHeight: CGFloat = 37
private let textFieldHorizontalMargin: CGFloat = 16.5
private let textFieldSpacing: CGFloat = 22
private let textFieldTopMargin: CGFloat = 38.8
private let textFieldWidth: CGFloat = 206

final class LoginViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    let transition = BubbleTransition()
   
    private let critterView = CritterView(frame: critterViewFrame)

    private lazy var emailTextField: UITextField = {
        let textField = createTextField(text: "Email")
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = createTextField(text: "Password")
        textField.isSecureTextEntry = true
        textField.returnKeyType = .go
        textField.rightView = showHidePasswordButton
        showHidePasswordButton.isHidden = true
        return textField
    }()

    private lazy var showHidePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: buttonVerticalMargin, left: 0, bottom: buttonVerticalMargin, right: buttonHorizontalMargin)
        button.frame = buttonFrame
        button.tintColor = .text
        button.setImage(#imageLiteral(resourceName: "Password-show"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "Password-hide"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        return button
    }()

    private let notificationCenter: NotificationCenter = .default

    deinit {
        notificationCenter.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        //signInButton.isEnabled = false
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = signUpButton.frame.width/2
        signInButton.layer.cornerRadius = 5
    }
    
    // MARK: - Segue for Transition
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "signUpSegue") {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
      }
    }

    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = signUpButton.center
        transition.bubbleColor = signUpButton.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = signUpButton.center
        transition.bubbleColor = signUpButton.backgroundColor!
        return transition
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let deadlineTime = DispatchTime.now() + .milliseconds(100)

        if textField == emailTextField {
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { // 🎩✨ Magic to ensure animation starts
                let fractionComplete = self.fractionComplete(for: textField)
                self.critterView.startHeadRotation(startAt: fractionComplete)
                self.passwordDidResignAsFirstResponder()
            }
        }
        else if textField == passwordTextField {
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { // 🎩✨ Magic to ensure animation starts
                self.critterView.isShy = true
                self.showHidePasswordButton.isHidden = false
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            passwordDidResignAsFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            critterView.stopHeadRotation()
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard !critterView.isActiveStartAnimating, textField == emailTextField else { return }

        let fractionComplete = self.fractionComplete(for: textField)
        critterView.updateHeadRotation(to: fractionComplete)

        if let text = textField.text {
            critterView.isEcstatic = text.range(of: "@") != nil
        }
    }
    
    // MARK: - Sign In / Sign Up / Forgot Password
    
    @IBAction func signIn(_ sender: Any) {
        view.endEditing(true)
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
           print("Success signing in!")
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
            self.present(controller!, animated: true, completion: nil)
           //self.performSegue(withIdentifier: "signInToHome", sender: nil)
        }, onError: { error in
           print("Error Signing In!")
        })
    }
    
    @IBAction func forgotPasswordReset(_ sender: Any) {
        AuthService.resetPassword(email: emailTextField.text!, onSuccess: {
            print("Email sent to reset password!")
            }, onError: { (error) in
                print("Could not send email to reset password")
                })
    }
    
    
    
    // MARK: - Private

    private func setUpView() {
        view.backgroundColor = .dark

         view.addSubview(critterView)
         setUpCritterViewConstraints()

        view.addSubview(emailTextField)
        setUpEmailTextFieldConstraints()

        view.addSubview(passwordTextField)
        setUpPasswordTextFieldConstraints()

        setUpGestures()
        setUpNotification()
        
    }

    private func setUpCritterViewConstraints() {
        critterView.translatesAutoresizingMaskIntoConstraints = false
        critterView.heightAnchor.constraint(equalToConstant: critterViewDimension).isActive = true
        critterView.widthAnchor.constraint(equalTo: critterView.heightAnchor).isActive = true
        critterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        critterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: critterViewTopMargin).isActive = true
    }

    private func setUpEmailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: critterView.bottomAnchor, constant: textFieldTopMargin).isActive = true
    }

    private func setUpPasswordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: textFieldSpacing).isActive = true
    }
    
  
    

    private func fractionComplete(for textField: UITextField) -> Float {
        guard let text = textField.text, let font = textField.font else { return 0 }
        let textFieldWidth = textField.bounds.width - (2 * textFieldHorizontalMargin)
        return min(Float(text.size(withAttributes: [NSAttributedStringKey.font : font]).width / textFieldWidth), 1)
    }

    private func stopHeadRotation() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        critterView.stopHeadRotation()
        passwordDidResignAsFirstResponder()
    }

    private func passwordDidResignAsFirstResponder() {
        critterView.isPeeking = false
        critterView.isShy = false
        showHidePasswordButton.isHidden = true
        showHidePasswordButton.isSelected = false
        passwordTextField.isSecureTextEntry = true
    }

    private func createTextField(text: String) -> UITextField {
        let borderColor = #colorLiteral(red: 0.3450980392, green: 0.7333333333, blue: 0.7176470588, alpha: 1)
        let view = UITextField(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: textFieldHeight))
        view.backgroundColor = .white
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 4.07
        view.tintColor = .dark
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        view.delegate = self
        view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        let frame = CGRect(x: 0, y: 0, width: textFieldHorizontalMargin, height: textFieldHeight)
        view.leftView = UIView(frame: frame)
        view.leftViewMode = .always

        view.rightView = UIView(frame: frame)
        view.rightViewMode = .always

        view.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        view.textColor = .text

        let attributes: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor.disabledText,
            .font : view.font!
        ]

        view.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)

        return view
    }

    // MARK: - Gestures

    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        stopHeadRotation()
    }

    // MARK: - Actions

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        let isPasswordVisible = !sender.isSelected
        sender.isSelected = isPasswordVisible
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        critterView.isPeeking = isPasswordVisible

        // 🎩✨ Magic to fix cursor position when toggling password visibility
        if let textRange = passwordTextField.textRange(from: passwordTextField.beginningOfDocument, to: passwordTextField.endOfDocument), let password = passwordTextField.text {
            passwordTextField.replace(textRange, withText: password)
        }
    }

    // MARK: - Notifications

    private func setUpNotification() {
        notificationCenter.addObserver(self, selector: #selector(applicationDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
    }

    @objc private func applicationDidEnterBackground() {
        stopHeadRotation()
    }

}
