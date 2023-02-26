//
//  AnnotationView.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 26/2/23.
//

import MapKit

class AnnotationView: MKAnnotationView{
    
    override var annotation: MKAnnotation? {
        willSet{
            guard let value = newValue as? Annotation else {return}
            detailCalloutAccessoryView = CallOut(annotation: value)
            
            let pinImage = UIImage(named: "bola-dragon")
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

            self.image = resizedImage
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
}
