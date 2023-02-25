//
//  HeroesListTableViewDelegate.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import UIKit


class HeroesListTableViewDelegate: NSObject, UITableViewDelegate {
    
    
    var didTapOnCell: ((Int) -> Void)?
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didTapOnCell?(indexPath.row)
    }
 
}
