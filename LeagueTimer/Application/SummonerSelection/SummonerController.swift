//
//  PlayerController.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 18/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol SummonerControllerDelegate: AnyObject {
    func presentError(error: NSError)
    func presentErrorMatch()
    func loadSummoners(array: [CoreSummoner])
    func savedSummer()
    func deleted()
}

class SummonerController: NSObject {
    let dataManager = DataManager()
    private weak var delegate: SummonerControllerDelegate?
    
    init(delegate: SummonerControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func saveSummoner(name: String) {
        if name != "" && name != " "{
            ApiManager().getSummoner(summonerName: name) { (summoner, error) in
                    if let errorSummoner = error {
                        self.delegate?.presentError(error: errorSummoner)
                    }
                    guard let summonerSelected = summoner else {return}
                    
                    if self.dataManager.isSummonerFavorite(id: summonerSelected.id) {
                        return
                    }
                    self.dataManager.saveSummoners(summonerToSave: summonerSelected)
                    self.delegate?.savedSummer()
                }
        }
    }
    
    func loadSummoners() {
        var arrayCoreData:[CoreSummoner] = []
        dataManager.loadSummoners { (array) in
            arrayCoreData = array
        }
        self.delegate?.loadSummoners(array: arrayCoreData)
    }
    
    func delete(summoner: CoreSummoner) {
        dataManager.delete(id: summoner.objectID) { (sucess) in
            if sucess {
                self.delegate?.deleted()
            }
        }
    }
    
    func getIfPlayerisOnline(summoner: CoreSummoner, completion: @escaping (Spectator?) -> Void){
        if let id = summoner.id {
            ApiManager().getMatch(id: id) { (match, error) in
                if let matchSelected = match {
                    completion(matchSelected)
                    return
                }
                self.delegate?.presentErrorMatch()
                completion(nil)
            }
        }
    }
}
