//
//  HomeViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import UIKit
import RealmSwift
import FSCalendar

class HomeViewController: BaseViewController {
    
    let repository = UserDiaryRepository()
    
    let homeView = HomeView()
    
    var tasks: Results<UserDiary>! {
        didSet {
            homeView.diaryListTableView.reloadData()
            print("TableView reloaded")
        }
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = repository.localRealm.objects(UserDiary.self)
        print("Realm is located at:", repository.localRealm.configuration.fileURL!)    // Realm file directory
        fetchDocumentZipFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    func fetchRealm() {
        tasks = repository.fetch()
    }
    
    override func configure() {
        super.configure()
        
        homeView.diaryListTableView.delegate = self
        homeView.diaryListTableView.dataSource = self
        homeView.calendar.delegate = self
        homeView.calendar.dataSource = self
        
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            //  Realm data update
            self.repository.updateFavorite(item: self.tasks[indexPath.row])
            self.fetchRealm()
            
        }
        
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "??????") { action, view, completionHandler in
            
            let task = self.tasks[indexPath.row]
            
            self.repository.delete(item: task)
            self.fetchRealm()
        }
        
        favorite.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [favorite])
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

extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "??????"
//    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star.fill")
//    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        <#code#>
//    }
    
    // date: yyyyMMdd hh:mm:ss => dateFormatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "???????????? ??????" : nil
    }
    
    //100 -> 25??? 3 -> 3
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
    }
}
