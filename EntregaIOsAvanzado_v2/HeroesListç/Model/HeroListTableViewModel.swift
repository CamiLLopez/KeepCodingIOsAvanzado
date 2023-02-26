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
        
        apiClient?.token = token
        
        apiClient?.getHeroes { [weak self] heroes, error in
            
            if let error {
                debugPrint("Un error ocurrio al obtener los heroes \(error)")
            }
            if error == nil {
                self?.updateFullItems(heroes: heroes)
            }
            
        }
    }
    
    func getHeroesFromCoreData() -> [HeroModel] {
        
        let heroesFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {

            let result = try context.fetch(heroesFetch)
            
            if let heroes = parseHeroModel(heroDB: result) {
                DispatchQueue.main.async {
                    self.updateUI?(heroes)
                }
               return heroes
            }else{
                debugPrint("Se produjo un error")
            }
        } catch let error as NSError {
            debugPrint("Error no hay nada en core data -> \(error)")
            return []
        }
        return []
    }
    
    func updateFullItems(heroes: [HeroModel]) -> Void {
        
        var fullItems: [HeroModel] = []
        let group = DispatchGroup()
        
        for hero in heroes {
            
            group.enter()
            
            apiClient?.getHeroLocation(with: hero.id) { heroLocations, error in
                var fullHero = hero
                if let firstLocation = heroLocations.first {
                    debugPrint(firstLocation)
                    fullHero.latitude = Double(firstLocation.latitud)
                    fullHero.longitude = Double(firstLocation.longitud)
                } else {
                    fullHero.latitude = 0.0
                    fullHero.longitude = 0.0
                }
                fullItems.append(fullHero)
                group.leave()
            }
            
        }

    group.notify(queue: .main) {
        
        debugPrint("Finalice")
        
        if !fullItems.isEmpty {
            self.saveHeroCoreData(heroModel: fullItems)
        }
      }
    }
    
    func parseHeroModel(heroDB: [Hero]) -> [HeroModel]? {
        
        var heroModelParsed: [HeroModel] = []
        
        for hero in heroDB {

        let id = hero.id
        let longitude = hero.longitude
        let latitude = hero.latitude
            
            
        guard let name = hero.name,
              let photo =  hero.photo,
              let description = hero.details else {
                return nil
            }
            
            let heroModel = HeroModel(id: String(describing: id), name: name, photo: photo, description: description, longitude: longitude, latitude: latitude)
            
            debugPrint(hero)
            heroModelParsed.append(heroModel)
        }
        return heroModelParsed
    }
        
        func saveHeroCoreData(heroModel: [HeroModel]) -> Void {
            
            for hero in heroModel {
                
                let heroToSave = Hero(context: context)
                
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
            self.updateUI?(heroModel)
        }
}
