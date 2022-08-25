//
//  SettingViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/25.
//

import UIKit
import Toast
import Zip

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

        //Button add Target
        settingView.backUpButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        settingView.restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
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
    
    @objc func backupButtonClicked() {
        print(#function)
        
        var urlPaths = [URL]()
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            self.view.makeToast("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        // path의 주소/default.realm 파일 주소를 realmFile에 저장
        let realmFile = path.appendingPathComponent("default.realm")
        //백업할 파일 확인
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            self.view.makeToast("백업할 파일이 없습니다")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        //백업 파일을 압축: URL
        
        //ActivityViewController
        
    }
    
    @objc func restoreButtonClicked() {
        print(#function)

    }
}
