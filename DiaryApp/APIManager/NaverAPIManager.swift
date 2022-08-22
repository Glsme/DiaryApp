//
//  NaverAPIManager.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class NaverAPIManager {
    static let shared = NaverAPIManager()
    
    private init () { }
    
    private let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
    
    func callRequest(query: String) {
        //https://openapi.naver.com/v1/search/image.xml?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=sim
        let url = "\(EndPoint.naverSearchImageURL)\(query)&display=10start=1sort=sim"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { response in
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
