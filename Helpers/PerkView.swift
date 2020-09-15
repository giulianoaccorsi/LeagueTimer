//
//  PerkView.swift
//  LeagueTimer
//
//  Created by giuliano.da.accorsi on 25/08/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit

enum TypeImage {
    case perk
    case image
}

protocol PerkViewDelegate {
    func updateIndex(index: Int)
    func imageTapped(isTapped: Bool)
}

class PerkView: UIView {
    
    var isImageTapped: Bool = true
    var indexImage = 0
    var delegate: PerkViewDelegate?
    var colorImage: UIImage?
    
    let spellPhoto: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.sizeToFit()
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    init(typeView: TypeImage) {
        super.init(frame: .zero)
        setUpView()
        if typeView == .perk {
            setupGesturePerk()
        }else {
            setupGestureItem()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhoto(photo: UIImage) {
        spellPhoto.image = photo
        colorImage = photo
    }
    
    func setupGesturePerk() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(indexImageTapped(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        spellPhoto.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupGestureItem() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
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
            spellPhoto.image = colorImage
            indexImage = 0
        }
        self.delegate?.updateIndex(index: indexImage)
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if isImageTapped {
            isImageTapped = false
            label.isHidden = false
            label.text = "-10%"
            spellPhoto.image = grayscaleImage(image: spellPhoto.image ?? UIImage())
        }else {
            isImageTapped = true
            spellPhoto.image = colorImage
            label.isHidden = true
        }
        self.delegate?.imageTapped(isTapped: isImageTapped)
    }
    
    func grayscaleImage(image: UIImage) -> UIImage {
        let ciImage = CIImage(image: image)
        let grayscale = ciImage!.applyingFilter("CIColorControls",
                                                parameters: [ kCIInputSaturationKey: 0.0 ])
        return UIImage(ciImage: grayscale)
    }
    
}

extension PerkView: ViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(spellPhoto)
        spellPhoto.addSubview(label)
    }
    
    func setUpConstraints() {
        
        spellPhoto.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    func setUpAdditionalConfiguration() {
        label.isHidden = true
    }
}
