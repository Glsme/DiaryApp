//
//  DiaryViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit

class DiaryViewController: BaseViewController {
    
    static var currentImage = ""
    
    let diaryView = DiaryView()
    
    override func loadView() {
        self.view = diaryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
        changeImage(image: DiaryViewController.currentImage)
    }

    override func configure() {
        diaryView.searchButton.addTarget(self, action: #selector(searchButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        
        transViewController(ViewController: SearchViewController(), type: .push)
    }
    
    func changeImage(image: String) {
        print(image)
        
        if image != "" {
            diaryView.selectImageView.kf.setImage(with: URL(string: image))
        }
    }
}
