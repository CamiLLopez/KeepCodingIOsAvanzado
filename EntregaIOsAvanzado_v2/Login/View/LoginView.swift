//
//  LoginView.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let headerLabel = {
        let label = UILabel()
        label.text = "Login"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let passwordTextField = {
        let textField = UITextField()
        textField.placeholder = "Insert your password"
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
   
    let emailTextField = {
        let textField = UITextField()
        textField.placeholder = "Insert your email"
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let messageView = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
  
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLoginButtonView() -> UIButton{
        return loginButton
    }
  
    func getEmailView()-> UITextField{
        return emailTextField
    }
    
    func getPasswordView()-> UITextField{
        return passwordTextField
    }
    
    func getMessageView()-> UILabel{
        return messageView
    }
    
    func setUpViews(){
        backgroundColor = .systemGray6
        
        
        addSubview(headerLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(messageView)
        
       NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.heightAnchor.constraint(equalToConstant: 50),
        
            emailTextField.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: 250),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            emailTextField.heightAnchor.constraint(equalToConstant: 30),
        
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 60),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 80),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            
            messageView.widthAnchor.constraint(equalToConstant: 20),
            messageView.topAnchor.constraint(equalTo: loginButton.topAnchor, constant: 80),
            messageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            messageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            messageView.heightAnchor.constraint(equalToConstant: 150),
            messageView.widthAnchor.constraint(equalToConstant: 20)
       
       ])
        
    }
    
}
