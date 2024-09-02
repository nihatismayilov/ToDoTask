//
//  Date+Extensions.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import Foundation

enum DateFormats: String, CaseIterable {
    case withSlashFormat = "dd/MM/yyyy"
    case mainDateFormat = "yyyy-MM-dd"
    case dateWithHour = "yyyy-MM-dd'T'HH:mm:ss"
    case dayMonth = "dd MMM"
}

extension Date {
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
