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
    
    func transViewController(storyboardName: String) {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: <#T##String#>)
    }
}
