//
//  LoginViewController.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import Foundation
import UIKit

protocol Login {
    
    func dismiss()
    
    func present(loginViewController: LoginViewController)
}


class LoginViewController: UIViewController {
    
    var mainView: LoginView {self.view as! LoginView}
    var viewModel = LoginViewModel()
    var loginButton: UIButton?
    var passwordTextField: UITextField?
    var emailTextField: UITextField?
    var messageView: UILabel?
    var login: String?
    var delegate: Login
    
    
    
    init(delegate: Login) {
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        
        let loginView = LoginView()
                
        loginButton = loginView.getLoginButtonView()
        emailTextField = loginView.getEmailView()
        passwordTextField = loginView.getPasswordView()
        messageView = loginView.getMessageView()
                
        view = loginView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton?.addTarget(self, action: #selector(didLoginTapped), for: .touchUpInside)
        
    }
    
    func setUpUpdateUI(){
        
        viewModel.updateLogin = { [weak self] login in
            
            DispatchQueue.main.async {
            self?.login = login
            debugPrint(login)
            self?.viewModel.saveInKeychain(token: login)
            self?.messageView?.text = "Login exitoso!"
            self?.dismiss(animated: true)
                
            self?.delegate.dismiss()
            }
        }
        
        //TODO Show alert con error
        /*viewModel?.updateError = { [weak self] error in
            
            DispatchQueue.main.async {
            var dialogMessage = UIAlertController(title: "Attention", message: "I am an alert message you cannot dissmiss.", preferredStyle: .alert)
                
                self?.present(dialogMessage, animated: true)
            
            }
        }*/
    }
    
    func getLogin(email: String, password: String){

        viewModel.fetchLogin(email: email , password: password)
    }
 
    @objc func didLoginTapped(sender: UIButton!) {
        
        guard let email = emailTextField?.text,
        !email.isEmpty else {
            print("email is empty")
         return
         }
        guard let password = passwordTextField?.text, !password.isEmpty else {
         print("Password is empty")
         return
         }
        
        self.getLogin(email: email, password: password)
        setUpUpdateUI()
    }
    
    func logout(){
        
        viewModel.fetchLogout()
    }
}
