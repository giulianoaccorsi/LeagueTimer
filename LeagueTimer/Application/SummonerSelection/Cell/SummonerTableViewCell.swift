//
//  PlayerTableViewCell.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 18/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SnapKit

class SummonerTableViewCell: UITableViewCell {
    
    static let identifier = "SummonerTableViewCell"
    
    let background: UIView = {
        let view = UIView(frame: .zero)
        view.layer.borderColor = UIColor.colorWidth.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let summonerName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont(name: "FrizQuadrataITCbyBT-Bold", size: 17)
        label.textColor = .colorText
        label.textAlignment = .center
        return label
    }()
    
    func setupCell(name: String) {
        self.backgroundColor = .background
        summonerName.text = name
        setUpView()
    }
}

extension SummonerTableViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(background)
        background.addSubview(summonerName)
    }
    
    func setUpConstraints() {
        background.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        summonerName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    func setUpAdditionalConfiguration() {
    }
    
}



