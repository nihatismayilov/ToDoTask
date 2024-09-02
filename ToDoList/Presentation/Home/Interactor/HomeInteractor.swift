//
//  HomeInteractor.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation
import Combine

protocol HomeInteractorProtocol: AnyObject {
    func fetchTodoList()
    func deleteTodo(by id: UUID)
    func updateTodo(by id: UUID, isCompleted: Bool)
}

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    var homeService: HomeService
    var coreDataService: CoreDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        homeService: HomeService,
        coreDataService: CoreDataService
    ) {
        self.homeService = homeService
        self.coreDataService = coreDataService
    }
    
    func fetchTodoList() {
        if DefaultsStorage.isFirstLaunch {
            homeService.fetchTodoList()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {
                    [weak self] completion in
                    guard let self else { return }
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        presenter?.todoListFetchFailure(error: error)
                    }
                },
                      receiveValue: { [weak self] todoData in
                    guard let self else { return }
                    guard let todos = todoData.todos else { return }
                    for todo in todos {
                        coreDataService.saveEntity(
                            entityName: Constants.Entity.todoEntity,
                            attributes: [
                                "id": UUID(),
                                "title": todo.todo,
                                "desc": "",
                                "createdAt": Date().toFormattedString(),
                                "updatedAt": Date().toFormattedString(),
                                "isCompleted": todo.completed
                            ])
                    }
                    DefaultsStorage.isFirstLaunch = false
                    presenter?.todoListFetched(data: fetchTodos())
                })
                .store(in: &cancellables)
        } else {
            presenter?.todoListFetched(data: fetchTodos())
        }
    }
    
    private func fetchTodos() -> [Todo] {
        let todoData = coreDataService.fetchEntities(entityName: Constants.Entity.todoEntity)
        var todos = [Todo]()
        for todo in todoData {
            let model = Todo(
                id: (todo.value(forKey: "id") as? UUID)!,
                title: todo.value(forKey: "title") as? String,
                desc: todo.value(forKey: "desc") as? String,
                createdAt: todo.value(forKey: "createdAt") as? String,
                updatedAt: todo.value(forKey: "updatedAt") as? String,
                isCompleted: todo.value(forKey: "isCompleted") as? Bool
            )
            todos.append(model)
        }
        return todos
    }
    
    func deleteTodo(by id: UUID) {
        coreDataService.deleteEntityById(entityName: Constants.Entity.todoEntity, id: id)
        presenter?.todoListFetched(data: fetchTodos())
    }
    
    func updateTodo(by id: UUID, isCompleted: Bool) {
        coreDataService.updateItem(
            entityName: Constants.Entity.todoEntity,
            id: id,
            propertyName: "isCompleted",
            newValue: isCompleted
        )
        presenter?.todoListFetched(data: fetchTodos())
    }
}
