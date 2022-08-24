//
//  DiaryListTableViewCell.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import UIKit
import SnapKit

class DiaryListTableViewCell: UITableViewCell {
    
    let preImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    func configureUI() {
        [preImageView, titleLabel, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        preImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.trailingMargin.equalTo(-10)
            make.width.height.equalTo(120)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY).multipliedBy(0.6)
            make.leadingMargin.equalTo(20)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY).multipliedBy(1.2)
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(20)
            make.width.equalTo(200)
        }
    }
}
