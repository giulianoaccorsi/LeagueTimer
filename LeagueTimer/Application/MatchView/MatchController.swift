//
//  HomeController.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit

enum JsonType: String {
    case champion = "champion"
    case spell = "spells"
}

protocol MatchControllerDelegate: AnyObject {
    func loadPlayersApp(players: [PlayerApp])
}

class MatchController: NSObject {
    private weak var delegate: MatchControllerDelegate?
    private let spectator: Spectator
    
    init(delegate: MatchControllerDelegate, spectator: Spectator) {
        self.delegate = delegate
        self.spectator = spectator
        super.init()
    }
    
    private func getArraySpell() -> [Spell] {
        var spells:[Spell] = []
        loadJson(fileName: .spell) { (spell, champion) in
            spells = spell ?? []
        }
        return spells
    }
    
    private func getArrayChampion() -> [Champion] {
        var champions:[Champion] = []
        loadJson(fileName: .champion) { (spell, champion) in
            champions = champion ?? []
        }
        return champions
    }
    
    
    private func getPlayerEnemies() -> [Player] {
        return spectator.participants.filter{$0.teamID == 100}
    }
    
    private func makePlayerApp(spell1: Spell?, spell2: Spell?, champion: Champion?) -> PlayerApp {
        let spell1Image = UIImage(named: spell1?.id ?? "")
        let spell1CD = spell1?.cooldown ?? 0
        let spell2Image = UIImage(named: spell2?.id ?? "")
        let spell2CD = spell2?.cooldown ?? 0
        let imageChampion = UIImage(named: champion?.id ?? "")
        let cooldown6 = champion?.cooldownLevel6 ?? 0
        let cooldown11 = champion?.cooldownLevel11 ?? 0
        let cooldown16 = champion?.cooldownLevel16 ?? 0
        let stringUltimate = "\(champion?.id ?? "")R"
        let ultimateImage = UIImage(named: stringUltimate)
        
        return PlayerApp(imageChampion: imageChampion ?? UIImage(), imageUltimate: ultimateImage ?? UIImage(), imageSpell1: spell1Image ?? UIImage(), imageSpell2: spell2Image ?? UIImage(), cooldown6: cooldown6, cooldown11: Int(cooldown11), cooldown16: cooldown16, cooldownSpell1: spell1CD, cooldownSpell2: spell2CD)

    }
    
    func getPlayerInMatch() {
        let players:[Player] = getPlayerEnemies()
        let spells = getArraySpell()
        let champions = getArrayChampion()
        var playerInMatch:[PlayerApp] = []
        
        for player in players {
            let spell1 = spells.filter{$0.key == player.spell1ID}.first
            let spell2 = spells.filter{$0.key == player.spell2ID}.first
            let champion = champions.filter{$0.key == String(player.championID)}.first
            let playerCell = makePlayerApp(spell1: spell1, spell2: spell2, champion: champion)
            playerInMatch.append(playerCell)
        }
        delegate?.loadPlayersApp(players: playerInMatch)
    }
    
    private func loadJson(fileName: JsonType, completion: ([Spell]?, [Champion]?) -> Void) {
        if let url = Bundle.main.url(forResource: fileName.rawValue, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                if fileName == .champion {
                    do {
                        let jsonData = try decoder.decode(ChampionResult.self, from: data)
                        completion(nil, jsonData.champion)
                    } catch {
                        print("error:\(error)")
                    }
                }else {
                    do {
                        let jsonData = try decoder.decode(SpellResult.self, from: data)
                        completion(jsonData.data,nil)
                    } catch {
                        print("error:\(error)")
                    }
                }
            }catch {
                print("Error: \(error)")
            }
        }
        return
    }
    
}

