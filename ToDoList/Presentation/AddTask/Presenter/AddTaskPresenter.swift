//
//  AddTaskPresenter.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 02.09.24.
//

import Foundation

protocol AddTaskPresenterProtocol: AnyObject {
    func saveTask(todo: Todo)
}

class AddTaskPresenter: AddTaskPresenterProtocol {
    weak var view: AddTaskViewProtocol?
    var interactor: AddTaskInteractorProtocol?
    var router: AddTaskRouterProtocol?
    
    func saveTask(todo: Todo) {
        interactor?.saveTask(todo: todo)
    }
}
