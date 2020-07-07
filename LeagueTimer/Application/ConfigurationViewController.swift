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
    
    var isImageTapped: Bool = true
    var isImageTapped2: Bool = true
    var indexImage = 0
    
    let spellPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = #imageLiteral(resourceName: "Ashe")
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont(name: "HiraginoSans-W3", size: 20)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .blue
        setUpView()
        setupGesture()
    }
    
    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(indexImageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        spellPhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func indexImageTapped(_ sender: UITapGestureRecognizer) {
        label.isHidden = false
        indexImage += 1
        switch indexImage {
        case 1:
            spellPhoto.image = grayscaleImage(image: spellPhoto.image ?? UIImage())
            label.text = "1"
        case 2:
            label.text = "2"
        case 3:
            label.text = "3"
        case 4:
            label.text = "4"
        case 5:
            label.text = "5"
        default:
            label.text = ""
            label.isHidden = true
            spellPhoto.image = #imageLiteral(resourceName: "Ashe")
            indexImage = 0
        }
        print("image tapped")
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if isImageTapped {
            isImageTapped = false
            label.isHidden = false
            label.text = "-10%"
            spellPhoto.image = grayscaleImage(image: spellPhoto.image ?? UIImage())
            print("image tapped")
            return
        }else {
            isImageTapped = true
            spellPhoto.image = #imageLiteral(resourceName: "Ashe")
            label.isHidden = true
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
        view.addSubview(spellPhoto)
        spellPhoto.addSubview(label)
    }
    
    func setUpConstraints() {
        
        spellPhoto.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    func setUpAdditionalConfiguration() {
        label.isHidden = true
    }
    
    
}
