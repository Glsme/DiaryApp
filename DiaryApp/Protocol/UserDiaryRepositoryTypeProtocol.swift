//
//  UserDiaryRepositoryTypeProtocol.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/26.
//

import Foundation
import RealmSwift

// 여러개의 테이블 => CRUD
protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort() -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func fetchDate(date: Date) -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func delete(item: UserDiary)
    func addItem(item: UserDiary)
}
