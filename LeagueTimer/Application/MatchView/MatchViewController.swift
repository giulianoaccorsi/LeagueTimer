//
//  ViewController.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 16/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SnapKit

class MatchViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var spectador: Spectator
    
    init(spectador: Spectator) {
        self.spectador = spectador
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dataSource = MatchDataSource(tableView: self.tableView)
    private lazy var controller = MatchController(delegate: self, spectator: self.spectador)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        controller.getPlayerInMatch()
        
    }
}

extension MatchViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpAdditionalConfiguration() {
        self.view.backgroundColor = .background
        self.tableView.allowsSelection = false
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    
}

extension MatchViewController: MatchControllerDelegate {
    func loadPlayersApp(players: [PlayerApp]) {
        dataSource.updatePlayers(players: players)
    }
}
