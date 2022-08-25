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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
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
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSACDiary_1")
            print("Archive Location: \(zipFilePath)")
            //ActivityViewController
            showActivityViewController()
        } catch {
            self.view.makeToast("압축을 실패했습니다.")
        }
    }
    
    func showActivityViewController() {
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            self.view.makeToast("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("SeSACDiary_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func restoreButtonClicked() {
        print(#function)
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy:  true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
}


extension SettingViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            self.view.makeToast("선택하신 파일에 오류가 있습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            self.view.makeToast("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        //경로의 마지막 패스(파일.확장자 ex: file.zip)를 저장
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.view.makeToast("복구가 완료되었습니다.")
                })
            } catch {
                self.view.makeToast("압축 해제에 실패했습니다.")
            }
            
        } else {
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("SeSACDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.view.makeToast("복구가 완료되었습니다.")
                    
                    self.dismiss(animated: true)
                })
            } catch {
                self.view.makeToast("압축 해제에 실패했습니다.")
            }
        }
    }
}
