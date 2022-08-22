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
    
    let imageCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: searchCollectionViewLayout())
        view.backgroundColor = .darkGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func configureUI() {
        [searchBar, imageCollectionView].forEach{
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
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
        }
    }
    
    static func searchCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
    
}
