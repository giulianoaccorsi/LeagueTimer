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
    
    let timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont(name: "HiraginoSans-W3", size: 20)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.textAlignment = .center
        return label
    }()
    
    let championPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "Ashe")
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let circleTimer: CircleTimer = {
        let timer = CircleTimer()
        return timer
    }()
    
    var timer: Timer?
    var timeLeft = 10
    var isImageTapped: Bool = true
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .blue
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
        setupGesture()
    }
    
    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        championPhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if isImageTapped {
            isImageTapped = false
            timeLeft = 5
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            championPhoto.image = grayscaleImage(image: championPhoto.image ?? UIImage())
            circleTimer.startTimer(duration: CFTimeInterval(timeLeft))
            print("image tapped")
        }
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            championPhoto.image = #imageLiteral(resourceName: "Ashe")
            timeLabel.text = ""
            isImageTapped = true
            timer?.invalidate()
        }
    }
    
    func grayscaleImage(image: UIImage) -> UIImage {
        let ciImage = CIImage(image: image)
        let grayscale = ciImage!.applyingFilter("CIColorControls",
                                                parameters: [ kCIInputSaturationKey: 0.0 ])
        return UIImage(ciImage: grayscale)
    }
}

extension ConfigurationViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(championPhoto)
        championPhoto.addSubview(circleTimer)
        championPhoto.addSubview(timeLabel)
    }
    
    func setUpConstraints() {
        
        championPhoto.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        circleTimer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpAdditionalConfiguration() {
        view.layoutIfNeeded()
        circleTimer.setUpBaseLayer()
    }
    
    
}
