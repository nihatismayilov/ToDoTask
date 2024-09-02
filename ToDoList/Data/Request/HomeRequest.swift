//
//  HomeRequest.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation

enum HomeRequest: Request {
    case fetchTodos

    var baseUrl: BaseURL {
        switch self {
        default:
                .base
        }
    }
    
    var endpoint: String {
        switch self {
        case .fetchTodos:
            return "todos"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .fetchTodos:
                .body([:])
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
}
