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
    
    // image 관련
    var delegate: SelectImageDelegate?
    var selectImage: UIImage?
    var selectIndexPath: IndexPath?
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(selectButtonClciked))
    }
    
    override func configure() {
        searchView.imageCollectionView.delegate = self
        searchView.imageCollectionView.dataSource = self
        searchView.imageCollectionView.prefetchDataSource = self
        searchView.imageCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        searchView.searchBar.delegate = self
    }
    
    func fetchImage(query: String) {
        NaverAPIManager.shared.callRequest(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.imageList.append(contentsOf: list)
            DispatchQueue.main.async {
                self.searchView.imageCollectionView.reloadData()
            }
        }
    }
    
    @objc func selectButtonClciked() {
        guard let selectImage = selectImage else {
            self.view.makeToast("사진을 선택해주세요")
            return
        }

        delegate?.sendImageData(image: selectImage)
        print(selectImage)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if imageList.count - 1 == indexPath.item && imageList.count < totalCount {
                startPage += 30
                fetchImage(query: searchView.searchBar.text!)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        //
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            imageList.removeAll()
            startPage = 1
            
            fetchImage(query: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageList.removeAll()
        searchView.imageCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.kf.setImage(with: URL(string: imageList[indexPath.item]))
        cell.layer.borderWidth = selectIndexPath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.red.cgColor : nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SearchCollectionViewCell else { return }
        
        selectImage = cell.imageView.image
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectIndexPath = nil
        selectImage = nil
        collectionView.reloadData()
    }
    
}
