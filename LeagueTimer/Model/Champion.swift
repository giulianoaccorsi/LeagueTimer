//
//  Champion.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 19/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation


// MARK: - ChampionResult
struct ChampionResult: Codable {
    let champion: [Champion]
}

// MARK: - Champion
struct Champion: Codable {
    let id, key: String
    let cooldownLevel6: Int
    let cooldownLevel11: Double
    let cooldownLevel16: Int
}

