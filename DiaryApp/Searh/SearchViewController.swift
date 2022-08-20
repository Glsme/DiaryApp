//
//  SearchViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .done, target: self, action: nil)
    }

}
