//
//  Data+Extensions.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

protocol DictionaryConvertible {
    var asDictionary: [String: Any] { get }
}

extension DictionaryConvertible {
    var asDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary: [String: Any] = [:]

        for child in mirror.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }

        return dictionary
    }
}
