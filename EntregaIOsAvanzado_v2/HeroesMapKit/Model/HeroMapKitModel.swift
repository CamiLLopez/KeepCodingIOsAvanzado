//
//  HeroMapKitModel.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 26/2/23.
//

import Foundation
import CoreData

class HeroMapKitModel: NSObject {
    
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    
    func getHeroesFromCoreData() -> [PlaceModel] {
        
        let heroesFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try context.fetch(heroesFetch)
            
            if let places = parseHeroToPlace(heroDB: result) {
                return places
                
            }
        } catch let error as NSError {
            debugPrint("Error no hay nada en core data -> \(error)")
            return []
        }
        return []
    }
    
    func parseHeroToPlace(heroDB: [Hero]) -> [PlaceModel]? {
        
        var heroPlaceParsed: [PlaceModel] = []
        
        for hero in heroDB {

        let id = hero.id
        let longitude = hero.longitude
        let latitude = hero.latitude
            
        guard let name = hero.name,
              let photo =  hero.photo else {
                return nil
            }
            let heroPlace = PlaceModel(name: name, latitude: latitude, longitude: longitude, image: photo)
            
            debugPrint(hero)
            heroPlaceParsed.append(heroPlace)
        }
        return heroPlaceParsed
    }
}
