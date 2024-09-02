//
//  Configuration.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation

protocol Request {
    var endpoint: String { get }
    
    var baseUrl: BaseURL { get }

    var method: HTTPMethod { get }
    
    var parameters: RequestParams { get }
    
    var headers: [String: String]? { get }
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum RequestParams {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?, isQuery: Bool = true)
}

struct JSON {
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
}

enum BaseURL: String {
    case base = "https://dummyjson.com/"
}
