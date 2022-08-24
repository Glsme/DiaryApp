//
//  DiaryViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit
import RealmSwift
import Toast

class DiaryViewController: BaseViewController {
    
    let localRealm = try! Realm()
    
    let diaryView = DiaryView()
    
    override func loadView() {
        self.view = diaryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveButtonCliced))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonCliced))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        diaryView.searchButton.addTarget(self, action: #selector(searchButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func saveButtonCliced() {
        
        guard let title = diaryView.firstTextField.text, !diaryView.firstTextField.text!.isEmpty else {
            self.view.makeToast("제목을 입력해주세요")
            return
        }
        guard let keyword = diaryView.secondTextField.text, !diaryView.secondTextField.text!.isEmpty else {
            self.view.makeToast("키워드를 입력해주세요")
            return
        }
        
        let content = diaryView.userTextView.text
        let task = UserDiary(diaryTitle: title, diaryKeyword: keyword, diaryContent: content, diaryDate: Date(), regDate: Date(), favorite: false, photo: nil)

        try! localRealm.write {
            localRealm.add(task)
            print("Realm Succeed")

        }
        
        dismiss(animated: true)
    }
    
    @objc func cancelButtonCliced() {
        dismiss(animated: true)
    }
    
    @objc func searchButtonClicked(_ sender: UIButton) {
        print(#function)
        
        let vc = SearchViewController()
        vc.delegate = self
        transViewController(ViewController: vc, type: .presentFullScreenNavigation)
    }
}

extension DiaryViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        diaryView.selectImageView.image = image
        print(#function)
    }
}
