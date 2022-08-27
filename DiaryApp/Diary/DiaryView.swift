//
//  DiaryView.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit
import SnapKit

final class DiaryView: BaseView {
    
    let selectImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    let searchButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 25
        view.backgroundColor = .darkGray
        view.setImage(UIImage(systemName: "photo"), for: .normal)
        view.tintColor = .white
        
        return view
    }()
    
    let firstTextField: LightGrayBordTextField = {
        let view = LightGrayBordTextField()
        view.placeholder = "제목"
        
        return view
    }()
    
    let secondTextField: LightGrayBordTextField = {
        let view = LightGrayBordTextField()
        view.placeholder = "키워드"
        
        return view
    }()
    
    let userTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        view.textColor = .black
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureUI() {
        [selectImageView, firstTextField, secondTextField, userTextView, searchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        selectImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.topMargin.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerX.equalTo(selectImageView.snp.trailing).multipliedBy(0.95)
            make.centerY.equalTo(selectImageView.snp.bottom).multipliedBy(0.95)
            make.width.height.equalTo(50)
        }
        
        firstTextField.snp.makeConstraints { make in
            make.top.equalTo(selectImageView.snp.bottom).offset(20)
            make.width.equalTo(selectImageView)
            make.height.equalTo(30)
            make.centerX.equalTo(selectImageView.snp.centerX)
        }
        
        secondTextField.snp.makeConstraints { make in
            make.top.equalTo(firstTextField.snp.bottom).offset(20)
            make.width.equalTo(selectImageView)
            make.height.equalTo(30)
            make.centerX.equalTo(selectImageView.snp.centerX)
        }
        
        userTextView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(selectImageView.snp.width)
            make.top.equalTo(secondTextField.snp.bottom).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}
