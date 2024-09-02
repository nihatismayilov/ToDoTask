//
//  HomeRouter.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    func navigateToDetail(for todo: Todo)
    func navigateToAddTask()
}

class HomeRouter {
    weak var viewController: UIViewController?
    
    static func build() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor(
            homeService: HomeServiceImpl(dispatcher: NetworkDispatcher()),
            coreDataService: CoreDataServiceImpl()
        )
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigateToDetail(for todo: Todo) {
        let vc = DetailRouter.build(with: todo)
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddTask() {
        let vc = AddTaskRouter.build()
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
