//
//  HomeViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        transViewController(ViewController: DiaryViewController(), type: .push)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryListTableViewCell.reuseIdentifier, for: indexPath) as? DiaryListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
