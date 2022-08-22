//
//  UnSplashAPIManager.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/22.
//

import Foundation
import Alamofire
import SwiftyJSON



class UnSplashAPIManager {
    static let shared = UnSplashAPIManager()
    
    private init () { }
        
    func callRequest(query: String) {
        //https://api.unsplash.com/search/photos?page=1&query=${img}&client_id=${Access_Key}&orientation=landscape&per_page=20
        let url = "\(EndPoint.unsplashSearchImageURL)page=1&=query=\(query)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
