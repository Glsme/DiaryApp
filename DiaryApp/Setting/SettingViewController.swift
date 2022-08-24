//
//  SettingViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/25.
//

import UIKit

class SettingViewController: BaseViewController {
    
    let settingView = SettingView()
    
    override func loadView() {
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        settingView.dataTableView.delegate = self
        settingView.dataTableView.dataSource = self
        settingView.dataTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
