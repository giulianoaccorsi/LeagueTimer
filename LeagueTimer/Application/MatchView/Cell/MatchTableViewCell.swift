//
//  PlayerTableViewCell.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 17/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit
import ValueStepper
import SnapKit

class MatchTableViewCell: UITableViewCell {
    
    var ultCooldown6, ultCooldown11, ultCooldown16: Int?
    var summoner1Cooldown: Int?
    var summoner2Cooldown: Int?
    
    static let identifier = "MatchTableViewCell"
    
    let championPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    let firstSummonerSpell: CooldownView = {
        let view = CooldownView()
        return view
    }()
    
    let secondSummonerSpell: CooldownView = {
        let view = CooldownView()
        return view
    }()
    
    let ultimatePhoto: CooldownView = {
        let view = CooldownView()
        return view
    }()
    
    let ionianBootsPhoto: PerkView = {
        let image = PerkView(typeView: .image)
        return image
    }()
    
    
    let perkPhoto: PerkView = {
        let image = PerkView(typeView: .image)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    let cdrPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "CDRIcon")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let ultimateHunterPhoto: PerkView = {
        let image = PerkView(typeView: .perk)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let valueStepper: ValueStepper = {
        let stepper = ValueStepper()
        stepper.tintColor = .white
        stepper.backgroundColor = .gray
        stepper.minimumValue = 0
        stepper.maximumValue = 45
        stepper.stepValue = 5
        return stepper
    }()
    
    let ultimateSegmentControl: UISegmentedControl = {
        let items:[String] = ["6", "11", "16"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .gray
        return segmentControl
    }()
    
    
    
    
    func setupCell(player: PlayerApp) {
        setUpView()
        self.championPhoto.image = player.imageChampion
        self.ultimatePhoto.setupCustomView(photo: player.imageUltimate, time: player.cooldown6)
        self.firstSummonerSpell.setupCustomView(photo: player.imageSpell1, time: player.cooldownSpell1)
        self.secondSummonerSpell.setupCustomView(photo: player.imageSpell2, time: player.cooldownSpell2)
    }
    
    @objc func changeUltimateValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            print("11")
        case 2:
            print("16")
        default:
            print("6")
        }
    }
    
    
    @objc func changeCDRValue(sender: ValueStepper) {
        print(sender.value)
    }
}


extension MatchTableViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(championPhoto)
        self.contentView.addSubview(firstSummonerSpell)
        self.contentView.addSubview(secondSummonerSpell)
        self.contentView.addSubview(ultimatePhoto)
        self.contentView.addSubview(ionianBootsPhoto)
        self.contentView.addSubview(perkPhoto)
        self.contentView.addSubview(ultimateHunterPhoto)
        self.contentView.addSubview(cdrPhoto)
        self.contentView.addSubview(valueStepper)
        self.contentView.addSubview(ultimateSegmentControl)
    }
    
    func setUpConstraints() {
        let widthTimer = 55
        let widthIcons = 40
        
        championPhoto.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        firstSummonerSpell.snp.makeConstraints { (make) in
            make.leading.equalTo(championPhoto.snp.trailing).offset(16)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.width.equalTo(widthTimer)
            make.height.equalTo(widthTimer)
        }
        
        secondSummonerSpell.snp.makeConstraints { (make) in
            make.leading.equalTo(firstSummonerSpell.snp.trailing).offset(4)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.width.equalTo(widthTimer)
            make.height.equalTo(widthTimer)
            
        }
        
        ultimatePhoto.snp.makeConstraints { (make) in
            make.top.equalTo(firstSummonerSpell.snp.bottom).offset(8)
            make.width.equalTo(widthTimer)
            make.height.equalTo(widthTimer)
            make.leading.equalTo(firstSummonerSpell.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
        ionianBootsPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(secondSummonerSpell.snp.top)
            make.leading.equalTo(secondSummonerSpell.snp.trailing).offset(20)
            make.width.equalTo(widthIcons)
            make.height.equalTo(widthIcons)
        }
        
        perkPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(ionianBootsPhoto.snp.top)
            make.leading.equalTo(ionianBootsPhoto.snp.trailing).offset(8)
            make.width.equalTo(widthIcons)
            make.height.equalTo(widthIcons)
        }
        
        ultimateHunterPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(ionianBootsPhoto.snp.top)
            make.leading.equalTo(perkPhoto.snp.trailing).offset(8)
            make.width.equalTo(widthIcons)
            make.height.equalTo(widthIcons)
        }
        
        cdrPhoto.snp.makeConstraints { (make) in
            make.top.equalTo(ionianBootsPhoto.snp.bottom).offset(8)
            make.leading.equalTo(ionianBootsPhoto.snp.leading)
            make.width.equalTo(widthIcons)
            make.height.equalTo(widthIcons)
        }
        valueStepper.snp.makeConstraints { (make) in
            make.leading.equalTo(cdrPhoto.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing).offset(-4)
            make.centerY.equalTo(cdrPhoto.snp.centerY)
            make.height.equalTo(20)
        }
        
        ultimateSegmentControl.snp.makeConstraints { (make) in
            make.leading.equalTo(ultimatePhoto.snp.trailing).offset(8)
            make.bottom.equalTo(ultimatePhoto.snp.bottom)
            make.width.equalTo(70)
        }
    }
    
    func setUpAdditionalConfiguration() {
        self.backgroundColor = .background
        self.layoutIfNeeded()
        self.ionianBootsPhoto.setupPhoto(photo: UIImage(named: "BotaIonia") ?? UIImage())
        self.perkPhoto.setupPhoto(photo: UIImage(named: "CosmicInsight") ?? UIImage())
        self.ultimateHunterPhoto.setupPhoto(photo: UIImage(named: "UltimateHunter") ?? UIImage())
        self.ionianBootsPhoto.delegate = self
        self.perkPhoto.delegate = self
        self.ultimateHunterPhoto.delegate = self
        ultimateSegmentControl.addTarget(self, action: #selector(changeUltimateValue), for: .valueChanged)
        valueStepper.addTarget(self, action: #selector(changeCDRValue(sender:)), for: .valueChanged)
        
    }
    
    
}

extension MatchTableViewCell: PerkViewDelegate {
    func updateIndex(index: Int) {
        print("Index Changed \(index)")
    }
    
    func imageTapped(isTapped: Bool) {
        print("ImagedTapped: \(isTapped)")
        
    }
    
    
}

