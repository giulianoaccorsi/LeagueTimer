//
//  PopupViewController.swift
//  LeagueTimer
//
//  Created by Giuliano Accorsi on 18/06/20.
//  Copyright © 2020 Giuliano Accorsi. All rights reserved.
//

import UIKit
import SnapKit

protocol PopupViewControllerDelegate: AnyObject {
    func getTextfieldString(name: String)
}

class PopupViewController: UIViewController {
    
    weak var delegate: PopupViewControllerDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .colorText
        label.text = "Adicionar Invocador"
        label.font = UIFont(name: "FrizQuadrataITCbyBT-Bold", size: 16)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = .white
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.colorWidth.cgColor
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

}

extension PopupViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
    }
    
    func setUpConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
            make.height.equalTo(30)
        }
    }
    
    func setUpAdditionalConfiguration() {
        textField.delegate = self
        textField.becomeFirstResponder()
        view.backgroundColor = .background
    }
    
    
}

extension PopupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.getTextfieldString(name: textField.text ?? "")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.getTextfieldString(name: textField.text ?? "")
        view.endEditing(true)
        return true
    }
}
