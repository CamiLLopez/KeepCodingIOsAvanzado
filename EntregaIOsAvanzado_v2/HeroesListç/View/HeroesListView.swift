//
//  HeroesListView.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import UIKit


class HeroesListView: UIView {
    
    let headerLabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dragon Ball Heroes"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.backgroundColor = .systemRed
        
        return label
    }()
    
    let logoutButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .cyan
        button.setTitle("Logout", for: .normal)
        button.contentVerticalAlignment = .center
        return button
        
    }()
    
    let heroesTableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HeroListViewCell.self, forCellReuseIdentifier: "HeroListViewCell")
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLogoutButton() -> UIButton{
        return logoutButton
    }
    
    func setUpViews(){
        
        backgroundColor = .white
        
        addSubview(headerLabel)
        addSubview(logoutButton)
        addSubview(heroesTableView)
        
        NSLayoutConstraint.activate([
        
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            headerLabel.heightAnchor.constraint(equalToConstant: 50),
            
            logoutButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            logoutButton.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor, constant: 280),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            logoutButton.heightAnchor.constraint(equalToConstant: 20),
            logoutButton.widthAnchor.constraint(equalToConstant: 30),
            
            heroesTableView.topAnchor.constraint(equalTo: logoutButton.bottomAnchor),
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        ])
    }
}
