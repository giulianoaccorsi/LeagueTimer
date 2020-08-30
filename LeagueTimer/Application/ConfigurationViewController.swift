//
//  ConfigurationViewController.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 16/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SnapKit

class ConfigurationViewController: UIViewController {
    
    var perkView: PerkView?
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .blue
        perkView = PerkView(typeView: .image, delegate: self)
        perkView?.isUserInteractionEnabled = true
        setUpView()
    }
}

extension ConfigurationViewController: ViewConfiguration {
    func buildViewHierarchy() {
        guard let safePerkView = perkView else{return}
        view.addSubview(safePerkView)
    }
    
    func setUpConstraints() {
        guard let safePerkView = perkView else{return}
        safePerkView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    func setUpAdditionalConfiguration() {
        perkView?.backgroundColor = .cyan
    }
}

extension ConfigurationViewController: PerkViewDelegate {
    func updateIndex(index: Int) {
    }
    
    func imageTapped(isTapped: Bool) {
    }
    
    
}
