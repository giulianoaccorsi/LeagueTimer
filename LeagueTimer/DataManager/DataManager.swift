//
//  DataManager.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 18/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//


import Foundation
import CoreData








class DataManager {
    
    private let summonerEntity: String = "CoreSummoner"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: summonerEntity)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveSummoners(summonerToSave: Summoner) {
        let context = persistentContainer.viewContext
        let coreSummoner = CoreSummoner(context: context)
        coreSummoner.id = summonerToSave.id
        coreSummoner.name = summonerToSave.name
        coreSummoner.accountID = summonerToSave.accountID
        do {
            try context.save()
        } catch {
            print("Error - DataManager - saveSummoners()")
        }
    }
    
    func loadSummoners(completion: ([CoreSummoner]) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: summonerEntity)
        let result = try? context.fetch(request)
        completion(result as? [CoreSummoner] ?? [])
    }
    
    func delete(id: NSManagedObjectID, completion: (Bool) -> Void) {
        let context = persistentContainer.viewContext
        let object = context.object(with: id)
        
        context.delete(object)
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func isSummonerFavorite(id: String) -> Bool {
        
        var array:[CoreSummoner] = []
        
        loadSummoners { (arrayCore) in
            array = arrayCore
        }
        
        let summoner = array.first { (coreSummoner) -> Bool in
            return coreSummoner.id == id
        }
        
        return summoner != nil
    }
    
}
