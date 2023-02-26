//
//  HeroDetailViewController.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 26/2/23.
//

import Foundation
import UIKit

class HeroDetailViewController: UIViewController {
    
    
    var mainView: HeroDetailView{ self.view as! HeroDetailView}
    
    init(heroeDetailModel: HeroModel){
        super.init(nibName: nil, bundle: nil)
        mainView.configure(heroeDetailModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = HeroDetailView()
    }
}
