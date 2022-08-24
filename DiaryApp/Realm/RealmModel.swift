//
//  RealmModel.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/24.
//

import Foundation
import RealmSwift

class UserDiary: Object {
    @Persisted var diaryTitle: String       // 제목(필수)
    @Persisted var diaryContent: String?    //내용(옵션)
    @Persisted var diaryDate = Date()       //작성 날짜(필수)
    @Persisted var regDate = Date()         //등록 날짜(필수)
    @Persisted var favorite: Bool           //즐겨찾기(필수)
    @Persisted var photo: String?           //사진(옵션)
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, diaryDate: Date, regDate: Date, favorite: Bool, photo: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.diaryDate = diaryDate
        self.regDate = regDate
        self.favorite = false
        self.photo = photo
    }
}
