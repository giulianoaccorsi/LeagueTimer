//
//  Spell.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 19/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Spell
struct SpellResult: Codable {
    let data: [Spell]
}

// MARK: - Datum
struct Spell: Codable {
    let name, id: String
    let cooldown, key: Int
}

