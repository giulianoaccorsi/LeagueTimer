//
//  PlayerViewController.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 18/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SnapKit
import PopupDialog

class SummonerViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var controller = SummonerController(delegate: self)
    private lazy var dataSource = SummonerDataSource(tableView: self.tableView, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.loadSummoners()
    }
    
    @objc func addPlayer() {
        let popUpViewController = PopupViewController()
        popUpViewController.delegate = self
        let popup = PopupDialog(viewController: popUpViewController,
                                buttonAlignment: .horizontal,
                                transitionStyle: .fadeIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true)
        
        let buttonOne = CancelButton(title: "Cancelar", height: 40) {
        }
        
        let buttonTwo = DefaultButton(title: "Adicionar", height: 40) {
        }
        
        buttonOne.backgroundColor = .background
        buttonOne.separatorColor = .colorWidth
        buttonTwo.separatorColor = .colorWidth
        buttonTwo.backgroundColor = .background
        buttonTwo.titleColor = .colorText
        
        popup.addButtons([buttonOne, buttonTwo])
        
        present(popup, animated: true, completion: nil)
    }
    
}

extension SummonerViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpAdditionalConfiguration() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addButton")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(addPlayer))
        self.navigationController?.navigationBar.barStyle = .black
        tableView.backgroundColor = .background
    }
}

extension SummonerViewController: PopupViewControllerDelegate {
    func getTextfieldString(name: String) {
        controller.saveSummoner(name: name)
    }
}

extension SummonerViewController: SummonerDataSourceDelegate {
    func didSelected(summoner: CoreSummoner) {
        controller.getIfPlayerisOnline(summoner: summoner) { (match) in
            if let matchSelected = match {
                let viewController = MatchViewController(spectador: matchSelected)
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
        }
    }
    
    func deleteSummoner(summoner: CoreSummoner) {
        controller.delete(summoner: summoner)
    }
    
    
}

extension SummonerViewController: SummonerControllerDelegate {
    func presentErrorMatch() {
        let title = "Partida não encontrada :c"
        let popup = PopupDialog(title: title, message: "Talvez o jogador não esteja em partida")
        popup.viewController.view.backgroundColor = .background
        popup.view.backgroundColor = .background
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.titleColor = .colorText
        let buttonOne = CancelButton(title: "Okay") {
            print("You canceled the car dialog.")
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func deleted() {
        controller.loadSummoners()
    }
    
    func loadSummoners(array: [CoreSummoner]) {
        dataSource.updateSummoners(summoners: array)
    }
    
    func savedSummer() {
        controller.loadSummoners()
    }
    
    func presentError(error: NSError) {
        let title = "Summoner não encontrado :c"
        let popup = PopupDialog(title: title, message: "Talvez tenha ocorrido algum erro de digitação.")
        popup.viewController.view.backgroundColor = .background
        popup.view.backgroundColor = .background
        let vc = popup.viewController as! PopupDialogDefaultViewController
        vc.titleColor = .colorText
        let buttonOne = CancelButton(title: "Okay") {
            print("You canceled the car dialog.")
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
}
