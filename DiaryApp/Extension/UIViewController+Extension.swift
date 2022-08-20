//
//  UIViewController+Extension.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/20.
//

import UIKit

extension UIViewController {
    
    enum Transition {
        case push, present
    }
    
    func transViewController<T: UIViewController>(ViewController vc: T, type: Transition) {
        switch type {
        case .push:
            self.navigationController?.pushViewController(vc, animated: true)
        case .present:
            present(vc, animated: true)
        }
    }
}
