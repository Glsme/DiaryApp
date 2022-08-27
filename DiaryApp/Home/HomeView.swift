//
//  HomeView.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import UIKit
import SnapKit
import FSCalendar

class HomeView: BaseView {
    
    let diaryListTableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 150
        
        return view
    }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
        
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
        self.addSubview(calendar)
    }
    
    override func setConstraints() {
        diaryListTableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
            make.topMargin.equalTo(300)
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
    }
}
