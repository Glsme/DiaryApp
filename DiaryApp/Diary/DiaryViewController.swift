//
//  DiaryViewController.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit

class DiaryViewController: BaseViewController {
    
    override func loadView() {
        self.view = DiaryView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
