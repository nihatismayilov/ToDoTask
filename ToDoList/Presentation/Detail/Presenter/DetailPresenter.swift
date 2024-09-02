//
//  DetailPresenter.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func updateTodo(todo: Todo)
    func deleteTodo(id: UUID)
}

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    var todo: Todo?
    
    func viewDidLoad() {
        view?.showData(todo: todo)
    }
    
    func deleteTodo(id: UUID) {
        interactor?.deleteTodo(id: id)
    }
    
    func updateTodo(todo: Todo) {
        interactor?.updateTodo(todo: todo)
    }
}
