//
//  File.swift
//  PockemonPVT
//
//  Created by Ehor Brel on 08.12.17.
//  Copyright © 2017 Ehor Brel. All rights reserved.
//

import Foundation
import CoreData
class CoreDataPokemonManager{
    
    static let sharedInstance = CoreDataPokemonManager()
    //var arrayOfPokemons: Array<PokemonCD>!
    
    
    private init(){
    }
    
    
    func getObjects(_ string: String) -> [NSManagedObject]{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: string)
        do {
            let arrayOfPokemons = try self.persistentContainer.viewContext.fetch(fetch)
            return arrayOfPokemons as! [NSManagedObject]
        } catch {
            fatalError("Failed to fetch pokemons: \(error)")
        }
        
    }
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PockemonPVT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
