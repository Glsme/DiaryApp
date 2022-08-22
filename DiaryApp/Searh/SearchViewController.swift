//
//  SearchViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    var startPage = 1
    var totalCount = 0
    var imageList: [String] = []
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .done, target: self, action: nil)
        fetchImage(query: "apple")
    }
    
    override func configure() {
        searchView.imageCollectionView.delegate = self
        searchView.imageCollectionView.dataSource = self
        searchView.imageCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
    }
    
    func fetchImage(query: String) {
        NaverAPIManager.shared.callRequest(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.imageList = list
            self.searchView.imageCollectionView.reloadData()
        }
    }
    
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setImage(data: imageList[indexPath.item])
        
        return cell
    }
}
