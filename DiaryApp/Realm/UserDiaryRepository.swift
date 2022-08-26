//
//  UserDiaryRepository.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/26.
//

import UIKit
import RealmSwift

class UserDiaryRepository: UserDiaryRepositoryType {
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
    }
    
    func fetchSort() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).sorted(byKeyPath: "regDate", ascending: true)
    }
    
    func fetchFilter() -> Results<UserDiary> {
        return localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'")
    }
    
    func updateFavorite(item: UserDiary) {
        try! localRealm.write {
            //하나의 레코드에서 특정 컬럼 하나만 변경
            item.favorite = !item.favorite
        }
    }
    
    func delete(item: UserDiary) {
        try! localRealm.write {
            localRealm.delete(item)
            removeImageFromDocument(fileName: "\(item.objectId).jpg")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지를 저장할 위치
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    func addItem(item: UserDiary) {
        
    }
}
