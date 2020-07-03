//
//  ViewConfiguration.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setUpConstraints()
    func setUpAdditionalConfiguration()
    func setUpView()
}

extension ViewConfiguration {
    func setUpView() {
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }
}
