//
//  DefaultsStorage.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import Foundation

struct DefaultsStorage {
    @UserDefaultsBacked(key: "isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}
