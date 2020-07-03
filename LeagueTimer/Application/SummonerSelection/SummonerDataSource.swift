//
//  PlayerDataSource.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 18/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit

protocol SummonerDataSourceDelegate: AnyObject {
    func deleteSummoner(summoner: CoreSummoner)
    func didSelected(summoner: CoreSummoner)
}

class SummonerDataSource: NSObject {
    
    private weak var tableView: UITableView?
    private var summoners: [CoreSummoner] = []
    weak var delegate: SummonerDataSourceDelegate?
    
    init(tableView: UITableView, delegate: SummonerDataSourceDelegate) {
        super.init()
        self.delegate = delegate
        self.tableView = tableView
        self.registerCells()
        self.setupDataSource()
    }
    
    private func registerCells() {
        tableView?.register(SummonerTableViewCell.self, forCellReuseIdentifier: SummonerTableViewCell.identifier)
    }
    
    private func setupDataSource() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    func updateSummoners(summoners: [CoreSummoner]) {
        self.summoners = summoners
        tableView?.reloadData()
    }
}

extension SummonerDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summoners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SummonerTableViewCell = tableView.dequeueReusableCell(withIdentifier: SummonerTableViewCell.identifier, for: indexPath) as? SummonerTableViewCell else { return UITableViewCell()}
        cell.setupCell(name: summoners[indexPath.row].name ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteSummoner(summoner: summoners[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(summoner: summoners[indexPath.row])
    }
}

