//
//  HomeEntity.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation

struct TodoResponseModel: Decodable {
    let todos: [TodoRemoteModel]?
}

struct TodoRemoteModel: Decodable {
    let id: Int?
    let todo: String?
    let completed: Bool?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}

struct Todo: DictionaryConvertible {
    var id = UUID()
    var title: String?
    var desc: String?
    var createdAt: String?
    var updatedAt: String?
    var isCompleted: Bool?
}
