//
//  HomeView.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    let diaryListTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 150
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureUI() {
        self.addSubview(diaryListTableView)
    }
    
    override func setConstraints() {
        diaryListTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
