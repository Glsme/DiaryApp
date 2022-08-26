//
//  UserDiaryRepositoryTypeProtocol.swift
//  DiaryApp
//
//  Created by Seokjune Hong on 2022/08/26.
//

import Foundation
import RealmSwift

protocol UserDiaryRepositoryType {
    func fetch() -> Results<UserDiary>
    func fetchSort() -> Results<UserDiary>
    func fetchFilter() -> Results<UserDiary>
    func updateFavorite(item: UserDiary)
    func delete(item: UserDiary)
}
