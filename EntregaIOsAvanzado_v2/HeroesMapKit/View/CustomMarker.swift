//
//  CustomMarker.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 26/2/23.
//

import Foundation
import MapKit

class CustomMarker: MKAnnotationView {
    
    override var annotation: MKAnnotation?{
        willSet{
            let pinImage = UIImage(named: "bola-dragon")
            let size = CGSize(width: 30, height: 30)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            
            self.image = resizedImage
        }
    }
    
}
