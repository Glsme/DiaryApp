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
        fetchDocumentZipFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    override func configure() {
        super.configure()
        
        homeView.diaryListTableView.delegate = self
        homeView.diaryListTableView.dataSource = self
        homeView.diaryListTableView.register(DiaryListTableViewCell.self, forCellReuseIdentifier: DiaryListTableViewCell.reuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonCliced))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black

    }
    
    @objc func plusButtonCliced() {
        transViewController(ViewController: DiaryViewController(), type: .presentFullScreenNavigation)
    }
    
    @objc func settingButtonClicked() {
        transViewController(ViewController: SettingViewController(), type: .presentFullScreenNavigation)
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
        cell.preImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            if let task = tasks?[indexPath.row] {
//                try! localRealm.write {
//                    localRealm.delete(task)
//                    removeImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
//                    print("delete Succeed")
//                }
//            }
//        }
//    }
}
