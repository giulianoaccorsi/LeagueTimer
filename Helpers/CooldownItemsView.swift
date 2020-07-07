//
//  CooldownItemsView.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 06/07/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit

class CooldownItemsView: UIView {
    
    let labelTouched: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont(name: "HiraginoSans-W3", size: 20)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    let itemPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
      var isImageTapped: Bool = true
      var indexImage = 0
    
    init() {
        super.init(frame: .zero)
        setUpView()
        setupGesture()
    }
    
    func setupCustomView(photo: UIImage) {
        itemPhoto.image = photo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(indexImageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        itemPhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(indexImageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        itemPhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func indexImageTapped(_ sender: UITapGestureRecognizer) {
        labelTouched.isHidden = false
        indexImage += 1
        switch indexImage {
        case 1:
            itemPhoto.image = grayscaleImage(image: itemPhoto.image ?? UIImage())
            labelTouched.text = "1"
        case 2:
            labelTouched.text = "2"
        case 3:
            labelTouched.text = "3"
        case 4:
            labelTouched.text = "4"
        case 5:
            labelTouched.text = "5"
        default:
            labelTouched.text = ""
            labelTouched.isHidden = true
//            labelTouched.image = #imageLiteral(resourceName: "Ashe")
            indexImage = 0
        }
        print("image tapped")
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if isImageTapped {
            isImageTapped = false
            labelTouched.isHidden = false
            labelTouched.text = "-10%"
            itemPhoto.image = grayscaleImage(image: itemPhoto.image ?? UIImage())
            print("image tapped")
            return
        }else {
            isImageTapped = true
//            itemPhoto.image = #imageLiteral(resourceName: "Ashe")
            labelTouched.isHidden = true
        }
    }
    

    
    func grayscaleImage(image: UIImage) -> UIImage {
        let ciImage = CIImage(image: image)
        let grayscale = ciImage!.applyingFilter("CIColorControls",
                                                parameters: [ kCIInputSaturationKey: 0.0 ])
        return UIImage(ciImage: grayscale)
    }
    
}

extension CooldownItemsView: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(itemPhoto)
        itemPhoto.addSubview(labelTouched)
    }
    
    func setUpConstraints() {
        itemPhoto.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        labelTouched.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpAdditionalConfiguration() {
        self.layoutIfNeeded()
        labelTouched.isHidden = true
    }
    
    
}
