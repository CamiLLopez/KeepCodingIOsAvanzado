//
//  ViewController.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import UIKit


class HomeTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupLayout()
        setupTabs()
    }
    
    private func setupTabs(){
        
        let heoresListNavigationController = UINavigationController(rootViewController: HeroesListTableViewController())
        let tabImage = UIImage(systemName: "list.bullet.circle")!
        heoresListNavigationController.tabBarItem = UITabBarItem(title: "Heroes", image: tabImage, tag: 0)
        
        let mapkitNavigationController = UINavigationController(rootViewController: HeroesMapkitViewController())
        
        let tabImg = UIImage(systemName: "network")!
        mapkitNavigationController.tabBarItem = UITabBarItem(title: "Heroes Map", image: tabImg, tag: 1)
        
        
        viewControllers = [heoresListNavigationController, mapkitNavigationController]
        
    }
    
    private func setupLayout() {
        
        tabBar.backgroundColor = .white
    }
}
