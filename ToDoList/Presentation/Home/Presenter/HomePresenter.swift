//
//  HomePresenter.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func todoListFetched(data: [Todo]?)
    func todoListFetchFailure(error: Error?)
    func deleteTodo(by id: UUID)
    func updateTodo(by id: UUID, isCompleted: Bool)
    func navigateToDetail(todo: Todo)
    func navigateToAddTask()
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchTodoList()
    }
    
    func todoListFetched(data: [Todo]?) {
        view?.showData(data: data ?? [])
    }
    
    func todoListFetchFailure(error: (any Error)?) {
        
    }
    
    func deleteTodo(by id: UUID) {
        interactor?.deleteTodo(by: id)
    }
    
    func updateTodo(by id: UUID, isCompleted: Bool) {
        interactor?.updateTodo(by: id, isCompleted: isCompleted)
    }
    
    func navigateToDetail(todo: Todo) {
        router?.navigateToDetail(for: todo)
    }
    
    func navigateToAddTask() {
        router?.navigateToAddTask()
    }
}
