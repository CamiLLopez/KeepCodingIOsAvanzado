//
//  KeychainManager.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import Foundation
import Security

final class KeychainManager {
    
    static var tokenKey: String = "myToken"
    var tokenValue: String?
    
   func deleteData(){
        
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeychainManager.tokenKey
        ]
        
        if(SecItemDelete(query as CFDictionary)) == noErr{
            
            debugPrint("Registro eliminado de keychain")
            
        }else{
            debugPrint("Se produjo un error al eliminar la información del usuario")
        }
    }
    
    func updateData(token: String){
        
        let token = token.data(using: .utf8)!
        
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeychainManager.tokenKey
        ]
        
        let attributes: [String:Any] = [
            kSecValueData as String: token
        ]
        if (SecItemUpdate(query as CFDictionary, attributes as CFDictionary)) == noErr {
            debugPrint("Updated")
        }else{
            debugPrint("Se produjo un error al actualizar la información del usuario")
        }
    }
    
    func readData(){

        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeychainManager.tokenKey,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
  
            if let existingToken = item as? [String: Any],
               let tokenData = existingToken[kSecValueData as String] as? Data,
               let token = String(data: tokenData, encoding: .utf8) {
                
                self.tokenValue = token
            }
        }else{
            debugPrint("Se produjo un error al consultar la información del usuario")
        }
    }
    func saveData(token: String){
        
        let token = token.data(using: .utf8)!
        
        let atributes: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeychainManager.tokenKey,
            kSecValueData as String: token
        ]
        if SecItemAdd(atributes as CFDictionary, nil) == noErr {
            debugPrint("Informacion del usuario guarda con exito")
        }else{
            debugPrint("Se produjo un error al guardar la información del usuario")
        }
        
    }
    
}
