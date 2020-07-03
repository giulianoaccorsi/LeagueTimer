//
//  Summoner.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation

struct Summoner: Codable {
    let id, accountID, name: String

    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "accountId"
        case name
    }
}
