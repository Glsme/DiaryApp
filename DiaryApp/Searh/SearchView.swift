//
//  SearchView.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.barStyle = .default
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureUI() {
        [searchBar].forEach{
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.trailing)
        }
    }
    
}
