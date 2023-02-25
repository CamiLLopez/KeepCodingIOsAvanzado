//
//  HeroesMapkitViewController.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import UIKit
import MapKit
import CoreLocation


class HeroesMapkitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        
        let mapView = HeroesMapkitView()
        view = mapView
    }
}

extension HeroesMapkitViewController: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if #available(iOS 14.0, *){
            switch manager.authorizationStatus{
            
            case .notDetermined:
                debugPrint("Not determinated")
            case .restricted:
                debugPrint("Restricted")
            case .denied:
                debugPrint("Denied")
            case .authorizedAlways:
                debugPrint("Always")
            case .authorizedWhenInUse:
                debugPrint("In Use")
            @unknown default:
                debugPrint("Unknown status")
            }
        }
    }
    
    //Ios 13 y anteriores
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .notDetermined:
            debugPrint("Not determinated")
        case .restricted:
            debugPrint("Restricted")
        case .denied:
            debugPrint("Denied")
        case .authorizedAlways:
            debugPrint("Always")
        case .authorizedWhenInUse:
            debugPrint("In Use")
        @unknown default:
            debugPrint("Unknown status")
        }
    }
}

