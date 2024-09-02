//
//  DetailInteractor.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    func updateTodo(todo: Todo)
    func deleteTodo(id: UUID)
}

class DetailInteractor: DetailInteractorProtocol {
    weak var presenter: DetailPresenterProtocol?
    var coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func deleteTodo(id: UUID) {
        coreDataService.deleteEntityById(entityName: Constants.Entity.todoEntity, id: id)
    }
    
    func updateTodo(todo: Todo) {
        coreDataService.updateItem(
            entityName: Constants.Entity.todoEntity,
            id: todo.id,
            updatedProperties: [
                "title": todo.title,
                "desc": todo.desc,
                "updatedAt": todo.updatedAt,
                "isCompleted": todo.isCompleted
            ]
        )
    }
}
