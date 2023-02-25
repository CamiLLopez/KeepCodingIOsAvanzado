//
//  HeroListTableViewModel.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 22/2/23.
//

import CoreData

class HeroListTableViewModel: NSObject {
    
    var updateUI: ((_ heroes: [HeroModel])-> Void)?
    
    
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    let apiClient: ApiClient?
    
    
    override init() {
        self.apiClient = ApiClient()
    }
    
    func fetchData(token: String){
        
        var heroModel: [HeroModel]?
        apiClient?.token = token
        
        apiClient?.getHeroes { [weak self] heroes, error in
            
            if let error {
                debugPrint("Un error ocurrio al obtener los heroes \(error)")
            }
            if error == nil {
                heroModel = self?.updateFullItems(heroes: heroes)
            }
            
            if let heroModel = heroModel {
                self?.saveHeroCoreData(heroModel: heroModel)
            }
        }
    }
    
    func getHeroesFromCoreData() -> [HeroModel] {
        
        let heroesFetch: NSFetchRequest<Heroes> = Heroes.fetchRequest()
        
        do {
            let result = try context.fetch(heroesFetch)
            debugPrint(result)
            let heroes = parseHeroModel(heroDB: result)
            return heroes
            
        } catch let error as NSError {
            debugPrint("Error no hay nada en core data -> \(error)")
            return []
        }
    }
    
    func updateFullItems(heroes: [HeroModel]) -> [HeroModel] {
        
        var fullItems: [HeroModel] = []
        
        for hero in heroes {
            
            apiClient?.getHeroLocation(heroId: hero.id) { heroLocations, error in
                var fullHero = hero
                if let firstLocation = heroLocations.first {
                    fullHero.latitude = Double(firstLocation.latitude)
                    fullHero.longitude = Double(firstLocation.longitude)
                } else {
                    fullHero.latitude = 0.0
                    fullHero.longitude = 0.0
                }
                fullItems.append(fullHero)
            }
        }
        return fullItems
    }
    
    func parseHeroModel(heroDB: [Heroes]) -> [HeroModel] {
        
        var heroModelParsed: [HeroModel] = []
        
        for hero in heroDB {
            
            let heroParse = HeroParseModel(
                id : String(describing: hero.id),
                name : hero.name,
                photo : hero.photo,
                description: hero.details,
                longitude: hero.longitude,
                latitude: hero.latitude
            )
            
            guard let heroToModel = try? HeroModel(from: heroParse as! Decoder) else{
                debugPrint("Was a problem with the decoder")
                return heroModelParsed
            }
            heroModelParsed.append(heroToModel)
        }
        
        return heroModelParsed
    }
        
        func saveHeroCoreData(heroModel: [HeroModel]) -> Void {
            
            for hero in heroModel {
                
                let heroToSave = Heroes(context: context)
                
                var uuid = UUID(uuidString: hero.id)
                heroToSave.id = uuid ?? UUID()
                heroToSave.photo = hero.photo
                heroToSave.name = hero.name
                heroToSave.details = hero.description
                heroToSave.longitude = hero.longitude ?? 0.0
                heroToSave.latitude = hero.latitude ?? 0.0
                
                do {
                    try context.save()
                    
                } catch let error {
                    debugPrint(error)
                }
            }
            
        }
}
