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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeImage(image: DiaryViewController.currentImage)
    }

    override func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveButtonCliced))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonCliced))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        diaryView.searchButton.addTarget(self, action: #selector(searchButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func saveButtonCliced() {
        dismiss(animated: true)
    }
    
    @objc func cancelButtonCliced() {
        dismiss(animated: true)
    }
    
    @objc func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        
        transViewController(ViewController: SearchViewController(), type: .push)
    }
    
    func changeImage(image: String) {
        if image != "" {
            diaryView.selectImageView.kf.setImage(with: URL(string: image))
        }
    }
}
