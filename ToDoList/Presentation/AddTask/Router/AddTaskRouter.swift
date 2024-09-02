//
//  AddTaskRouter.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 02.09.24.
//

import UIKit

protocol AddTaskRouterProtocol: AnyObject {
}

class AddTaskRouter: AddTaskRouterProtocol {
    static func build() -> UIViewController {
        let view = AddTaskViewController()
        let interactor = AddTaskInteractor(
            coreDataService: CoreDataServiceImpl()
        )
        let presenter = AddTaskPresenter()
        let router = AddTaskRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
