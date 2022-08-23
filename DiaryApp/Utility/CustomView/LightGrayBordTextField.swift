//
//  LightGrayTextField.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit

class LightGrayBordTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        textAlignment = .center
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        textColor = .black
    }
}
