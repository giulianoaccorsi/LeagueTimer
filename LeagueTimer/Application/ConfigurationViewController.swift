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
        perkView = PerkView(typeView: .image)
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
            make.topMargin.equalTo(30)
            make.leading.equalTo(40)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
    
    func setUpAdditionalConfiguration() {
        perkView?.backgroundColor = .yellow
    }
}

extension ConfigurationViewController: PerkViewDelegate {
    func updateIndex(index: Int) {
    }
    
    func imageTapped(isTapped: Bool) {
    }
    
    
}
