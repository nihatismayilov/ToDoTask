//
//  NetworkErrors.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation

enum NetworkErrors: Error, LocalizedError, Equatable {
    case connection
    case badInput
    case noData
    case unauthorized
    case notFound
    case methodNotAllowed
    case badRequest
    case notSupportedURL
    case unknownError(Int)
    case messageError(String)
    
    var errorDescription: String? {
        switch self {
        case .connection:
            return "No connection"
        case .badInput:
            return "Bad input"
        case .noData:
            return "No data found"
        case .unauthorized:
            return "Unauthorized"
        case .notFound:
            return "404 Not found"
        case .methodNotAllowed:
            return "This http method is not allowed"
        case .badRequest:
            return "Bad reques"
        case .notSupportedURL:
            return "URL not supported"
        case .unknownError(let code):
            return "\(code) - Unknown error"
        case .messageError(let message):
            return message
        }
    }
}
