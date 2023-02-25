//
//  LoginViewModel.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import Foundation
import UIKit

class LoginViewModel: NSObject {
    
    var updateLogin: ((_ token: String)->Void)?
    
    var updateError: ((_ error: String)->Void)?
    
    let keychain = KeychainManager()
    
    
    
    override init() {
        
    }
    
    func fetchLogin(email: String, password: String){
        
        let email: String? = email
        let password: String? = password
        
        var apiClient = ApiClient()
        
        apiClient.login(user: email!, password: password!) { loginToken, error in
            
            if let error {
                self.updateError?(error.localizedDescription)
            }
            
            if let loginToken {
                self.updateLogin?(loginToken)
            }
        }
    }
    
    func saveInKeychain(token: String){
        
        let token = token
        
        self.keychain.saveData(token: token)
    }
    
    func fetchLogout(){
        
        self.keychain.deleteData()
        
    }
}
