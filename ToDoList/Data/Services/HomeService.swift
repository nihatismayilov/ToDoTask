//
//  HomeService.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Combine

protocol HomeService {
    var dispatcher: Dispatcher {get set}
    func fetchTodoList() -> AnyPublisher<TodoResponseModel, Error>
}

class HomeServiceImpl: HomeService {
    var dispatcher: Dispatcher
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    func fetchTodoList() -> AnyPublisher<TodoResponseModel, any Error> {
        let request = HomeRequest.fetchTodos
        return dispatcher.execute(for: request)
    }
}
