//
//  HeroesListTableViewController.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import UIKit
import CoreData

class HeroesListTableViewController: UIViewController {
    
    var mainView: HeroesListView { self.view as! HeroesListView}
    var heroes : [HeroModel] =  []
    var tableViewDataSource: HeroesListTableViewDataSource?
    var viewModel: HeroListTableViewModel?
    var tableViewDelegate: HeroesListTableViewDelegate?
    var logoutButton: UIButton?
    var loginViewController: LoginViewController?
    
    override func loadView() {
        
        let heroView = HeroesListView()
        logoutButton = heroView.getLogoutButton()
        
        view = heroView
        
        tableViewDataSource = HeroesListTableViewDataSource(tableView: mainView.heroesTableView)
        
        mainView.heroesTableView.dataSource = tableViewDataSource
        
        tableViewDelegate = HeroesListTableViewDelegate()
        mainView.heroesTableView.delegate = tableViewDelegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HeroListTableViewModel()
        
        let tokenResult = validateLogin()
        
        if let tokenResult {
            getHeroes(token: tokenResult)
            setUpUpdateUI()
        }
        setUpTableDelegate()
        
        logoutButton?.addTarget(self, action: #selector(didLogoutTapped), for: .touchUpInside)
    }
    
    func setUpTableDelegate(){
            
        tableViewDelegate?.didTapOnCell = { [weak self] index in
            
            guard let dataSource = self?.tableViewDataSource else {
                return
            }
            
           let hero = dataSource.heroes[index]
            
           let heroDetailViewController = HeroDetailViewController(heroeDetailModel: hero)
            
           self?.present(heroDetailViewController, animated: true)
        }
    }
    
    @objc func didLogoutTapped(sender: UIButton!) {
        
        let loginViewController = LoginViewController(delegate: self)
        loginViewController.logout()
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController: loginViewController)
    }
    
    func validateLogin() -> String? {
        
        let keychainManager = KeychainManager()
        keychainManager.readData()
        
        let loginViewController = LoginViewController(delegate: self)
        
        if keychainManager.tokenValue == nil {
            
            self.present(loginViewController: loginViewController)
        }
        
        return keychainManager.tokenValue
    }
    
    func setUpUpdateUI(){
        
         viewModel?.updateUI = { [weak self] heroes in
             self?.tableViewDataSource?.heroes = heroes
         }
     }
     
     private func getHeroes(token: String) -> Void {
    
         if let heroes = viewModel?.getHeroesFromCoreData(){
             
             if heroes.isEmpty {
                 debugPrint("heroes esta vacio")
                 viewModel?.fetchData(token: token)
             }
         }
     }
}

extension HeroesListTableViewController: Login {
    
    func dismiss() {
        
        self.loginViewController?.dismiss(animated: true)
        
    }
    
    func present(loginViewController: LoginViewController) {
        
        loginViewController.modalPresentationStyle = .fullScreen
        
        self.present(loginViewController, animated: true)
    }
    
}

