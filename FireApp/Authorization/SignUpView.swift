//
//  SignUpView.swift
//  FireApp
//
//  Created by Pavel Bogart on 23/02/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    var submitAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let mainStackView = createStackView(views: [nametextField,
                                                    emailTextField,
                                                    passwordTextField,
                                                    confirmPasswordTextField,
                                                    submitButton,
                                                    cancelButton])
        addSubview(backgroundImageView)
        addSubview(mainStackView)
        
        backgroundImageView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        mainStackView.setAnchor(width: self.frame.width - 60, height: 310)
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Bitmap")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nametextField: UITextField = {
        let tf = UITextField(placeHolder: "Name")
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeHolder: "Email")
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(placeHolder: "Password")
        return tf
    }()
    
    let confirmPasswordTextField: UITextField = {
        let tf = UITextField(placeHolder: "Confirm Password")
        return tf
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(title: "Submit", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(title: "Cancel", borderColor: .redBorderColor)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSubmit() {
        submitAction?()
    }
    
    @objc func handleCancel() {
        cancelAction?()
    }
    
    
}
