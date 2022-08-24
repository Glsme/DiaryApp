//
//  SettingView.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/25.
//

import UIKit
import SnapKit

class SettingView: BaseView {
    
    let backUpButton: UIButton = {
        let view = UIButton()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.setTitle("백업", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    let restoreButton: UIButton = {
        let view = UIButton()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.setTitle("복구", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    let dataTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureUI() {
        [backUpButton, restoreButton, dataTableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backUpButton.snp.makeConstraints { make in
            make.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.4)
            make.height.equalTo(50)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leadingMargin.equalTo(20)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.4)
            make.height.equalTo(50)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailingMargin.equalTo(-20)
        }
        
        dataTableView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.top.equalTo(restoreButton.snp.bottom).offset(20)
        }
    }
}

