//
//  CooldownView.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 03/07/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit

class CooldownView: UIView {
    
    let timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont(name: "HiraginoSans-W3", size: 20)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.textAlignment = .center
        return label
    }()
    
    let spellPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    let circleTimer: CircleTimer = {
        let timer = CircleTimer()
        return timer
    }()
    
    var timer: Timer?
    var timeLeft:Int = 0
    var timeSaved:Int = 0
    var isImageTapped: Bool = true
    var colorImage: UIImage?
    
    init() {
        super.init(frame: .zero)
        setUpView()
        setupGesture()
    }
    
    func setupCustomView(photo: UIImage, time: Int) {
        self.timeLeft = time
        self.timeSaved = timeLeft
        self.colorImage = photo
        spellPhoto.image = photo
        circleTimer.setUpBaseLayer()
    }
    
    func updateTime(time: Int) {
        self.timeLeft = time
        self.timeSaved = timeLeft
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        spellPhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if isImageTapped {
            isImageTapped = false
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            spellPhoto.image = grayscaleImage(image: spellPhoto.image ?? UIImage())
            circleTimer.startTimer(duration: CFTimeInterval(self.timeLeft))
            print("image tapped")
        }
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
        
        if timeLeft <= 0 {
            self.timeLeft = timeSaved
            spellPhoto.image = self.colorImage ?? UIImage()
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

extension CooldownView: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(spellPhoto)
        spellPhoto.addSubview(circleTimer)
        spellPhoto.addSubview(timeLabel)
    }
    
    func setUpConstraints() {
        spellPhoto.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        circleTimer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpAdditionalConfiguration() {
        self.layoutIfNeeded()
        circleTimer.setUpBaseLayer()
    }
    
    
}
