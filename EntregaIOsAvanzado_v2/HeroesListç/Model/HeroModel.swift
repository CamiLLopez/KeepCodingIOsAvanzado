//
//  HeroModel.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

struct HeroModel: Decodable {
    
    var id: String
    var name: String
    var photo: String
    var description: String
    var longitude: Double?
    var latitude: Double?
}

