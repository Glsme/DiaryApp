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
    
    private init() { }
    
    private let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
    
    typealias completionHandler = (Int, [String]) -> Void
    
    func callRequest(query: String, startPage: Int, completionHandler: @escaping completionHandler ) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "\(EndPoint.naverSearchImageURL)query=\(text)&display=30&start=\(startPage)"
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let totalCount = json["total"].intValue
                let list = json["items"].arrayValue.map{ $0["link"].stringValue }
                
                completionHandler(totalCount, list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
