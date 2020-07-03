//
//  HomeViewDataSource.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit

class MatchDataSource: NSObject {
    
    private weak var tableView: UITableView?
    private var players: [PlayerApp] = []
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.registerCells()
        self.setupDataSource()
    }
    
    private func registerCells() {
        tableView?.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.identifier)
    }
    
    private func setupDataSource() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
    func updatePlayers(players: [PlayerApp]) {
        self.players = players
        tableView?.reloadData()
    }
}

extension MatchDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MatchTableViewCell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as? MatchTableViewCell else { return UITableViewCell()}
        cell.setupCell(player: players[indexPath.row])
        return cell
    }
}

