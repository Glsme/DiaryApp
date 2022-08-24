//
//  HomeViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>! {
        didSet {
            homeView.diaryListTableView.reloadData()
            print("TableView reloaded")
        }
    }
    
    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tasks = localRealm.objects(UserDiary.self)
        print("Realm is located at:", localRealm.configuration.fileURL!)    // Realm file directory
    }
    
    override func configure() {
        super.configure()
        
        homeView.diaryListTableView.delegate = self
        homeView.diaryListTableView.dataSource = self
        homeView.diaryListTableView.register(DiaryListTableViewCell.self, forCellReuseIdentifier: DiaryListTableViewCell.reuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonCliced))
        navigationItem.rightBarButtonItem?.tintColor = .black

    }
    
    @objc func plusButtonCliced() {
        transViewController(ViewController: DiaryViewController(), type: .presentFullScreenNavigation)
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지를 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    func saveImageFromDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save Error", error)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryListTableViewCell.reuseIdentifier, for: indexPath) as? DiaryListTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = tasks[indexPath.row].diaryTitle
        cell.dateLabel.text = String(describing: tasks[indexPath.row].diaryDate)
        cell.regDateLabel.text = String(describing: tasks[indexPath.row].regDate)
        
        return cell
    }
    
    
}
