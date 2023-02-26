//
//  HeroesMapkitViewController.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import MapKit
import CoreLocation

class HeroesMapkitViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var mapView: HeroesMapkitView?
    var viewModel: HeroMapKitModel?
    let initialLatitude: Double = 0.0
    let initialLongitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HeroMapKitModel()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        
        mapView?.delegate = self
        mapView?.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        moveToCoordinates(initialLatitude, initialLongitude)
        
        if let places = viewModel?.getHeroesFromCoreData() {
            let annotation = places.map {
                Annotation(place: $0)
            }
            
            mapView?.showAnnotations(annotation, animated: true)

        }
    }
    
    override func loadView() {
        
        view = HeroesMapkitView()
    }
    
    func moveToCoordinates(_ latitude: Double, _ longitude: Double){
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 180 , longitudeDelta: 360)
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView?.setRegion(region, animated: true)
    }
}

extension HeroesMapkitViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        debugPrint("hola annotation \(annotation)")
        
        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        if let annotation = annotation as? Annotation{
            annotationView?.canShowCallout = true
            annotationView?.detailCalloutAccessoryView = CallOut(annotation: annotation)
            
            return annotationView
        }
        
        return nil
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

