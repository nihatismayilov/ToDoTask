//
//  HomeViewControlle.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showData(data: [Todo])
}

class HomeViewController: UIViewController, HomeViewProtocol {
    // MARK: - Variables
    var presenter: HomePresenterProtocol?
    private var todos: [Todo] = []
    
    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        tableView.addCell(type: TodoTableViewCell.self)
        
        return tableView
    }()
    
    // MARK: - Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        presenter?.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(listUpdated), name: NSNotification.Name("listUpdate"), object: nil)
    }
    
    // MARK: - Initializations
    private func initViews() {
        navigationItem.title = "Todo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didTap)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red600
        
        view.backgroundColor = .background
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Functions
    func showData(data: [Todo]) {
        todos = data
        tableView.reloadData()
    }
    
    @objc func didTap(_ sender: UIButton) {
        presenter?.navigateToAddTask()
    }
    
    @objc func listUpdated() {
        presenter?.viewDidLoad()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(type: TodoTableViewCell.self)
        
        cell.setupCellWith(data: todos[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present detail view controller
        presenter?.navigateToDetail(todo: todos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteTodo(by: todos[indexPath.row].id)
        }
    }
}

extension HomeViewController: TodoTableViewCellDelegate {
    func markAsComplete(_ cell: TodoTableViewCell, isCompleted: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            presenter?.updateTodo(by: todos[indexPath.row].id, isCompleted: isCompleted)
        }
    }
}
