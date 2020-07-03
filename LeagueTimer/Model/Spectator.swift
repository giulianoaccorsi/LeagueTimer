//
//  Spectator.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation

struct Spectator: Codable {
    let participants: [Player]
    let gameStartTime, gameLength: Int

    enum CodingKeys: String, CodingKey {
        case participants
        case gameStartTime, gameLength
    }
}

// MARK: - Participant
struct Player: Codable {
    let teamID, spell1ID, spell2ID, championID: Int
    let summonerName: String
    let perks: Perks

    enum CodingKeys: String, CodingKey {
        case teamID = "teamId"
        case spell1ID = "spell1Id"
        case spell2ID = "spell2Id"
        case championID = "championId"
        case summonerName
        case perks
    }
}

// MARK: - Perks
struct Perks: Codable {
    let perkIDS: [Int]
    let perkStyle, perkSubStyle: Int

    enum CodingKeys: String, CodingKey {
        case perkIDS = "perkIds"
        case perkStyle, perkSubStyle
    }
}
