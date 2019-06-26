//
//  SignUpViewController.swift
//  FireApp
//
//  Created by Pavel Bogart on 23/02/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {

    var signupView: SignUpView!
    var defaults = UserDefaults.standard
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setupView()
    }
    
    func setupView() {
        let mainView = SignUpView(frame: self.view.frame)
        self.signupView = mainView
        signupView.submitAction = submitButtonPressed
        signupView.cancelAction = cancelButtonPressed
        view.addSubview(signupView)
        signupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func submitButtonPressed() {
        guard let email = signupView.emailTextField.text else { return }
        guard let password = signupView.passwordTextField.text else { return }
        guard let name = signupView.nametextField.text else { return }
        
        let userData: [String: Any] = [
            "name": name
        ]
        
        Auth.auth().createUserAndRetrieveData(withEmail: email, password: password) { (result, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                self.defaults.set(false, forKey: "UserIsLoggedIn")
                print("Successfully created a user:", uid)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

}
