//
//  String+Extensions.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import UIKit

extension String? {
    var orEmpty: String {
        self ?? ""
    }
    var isNilOrEmpty: Bool {
        self == nil || self == ""
    }
}

extension String {
    func convertToDate() -> Date? {
        let formatTypes: [DateFormats] = DateFormats.allCases
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "az_AZ")
        let currentFormat = formatTypes.first { format in
            formatter.dateFormat = format.rawValue
            guard formatter.date(from: self) != nil else { return false }
            return true
        }
        
        guard !currentFormat.isNil else { return nil }
        guard let date = formatter.date(from: self) else { return nil }
        return date
    }
}

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
