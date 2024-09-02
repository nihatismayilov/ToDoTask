//
//  AddTaskInteractor.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 02.09.24.
//

import Foundation

protocol AddTaskInteractorProtocol: AnyObject {
    func saveTask(todo: Todo)
}

class AddTaskInteractor: AddTaskInteractorProtocol {
    weak var presenter: AddTaskPresenterProtocol?
    var coreDataService: CoreDataService
    
    init(
        coreDataService: CoreDataService
    ) {
        self.coreDataService = coreDataService
    }
    
    func saveTask(todo: Todo) {
        coreDataService.saveEntity(
            entityName: Constants.Entity.todoEntity,
            attributes: todo.asDictionary
        )
    }
}
