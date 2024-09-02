//
//  DetailRouter.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import UIKit

protocol DetailRouterProtocol: AnyObject {
}

class DetailRouter: DetailRouterProtocol {
    static func build(with todo: Todo) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor(
            coreDataService: CoreDataServiceImpl()
        )
        let presenter = DetailPresenter()
        let router = DetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        presenter.todo = todo
        
        return view
    }
}
