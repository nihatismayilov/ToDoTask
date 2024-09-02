//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func showData(todo: Todo?)
}

class DetailViewController: UIViewController, DetailViewProtocol {
    // MARK: - Variables
    var presenter: DetailPresenterProtocol?
    var todo: Todo?
    
    // MARK: - UI Components
    private lazy var titleHeaderLabel = UILabel(
        text: "Title",
        textColor: .secondaryText,
        font: .systemFont(ofSize: 12)
    )
    private let titleBackgroundView = UIView(
        backgroundColor: .secondaryBackground,
        cornerRadius: 16
    )
    private let titlePlaceholderLabel = UILabel(
        text: "Example: Wash car tomorrow",
        textColor: .secondaryText,
        font: .systemFont(ofSize: 18)
    )
    private lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .primaryText
        textView.font = .systemFont(ofSize: 18, weight: .medium)
        
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var descriptionHeaderLabel = UILabel(
        text: "Description",
        textColor: .secondaryText,
        font: .systemFont(ofSize: 12)
    )
    private let descriptionBackgroundView = UIView(
        backgroundColor: .secondaryBackground,
        cornerRadius: 16
    )
    private let descriptionPlaceholderLabel = UILabel(
        text: "Details here...",
        textColor: .secondaryText,
        font: .systemFont(ofSize: 14)
    )
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .primaryText
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        
        textView.delegate = self
        
        return textView
    }()
    private let saveButton = BaseButton(
        title: "Save",
        tintColor: .neutral1,
        backgroundColor: .red600,
        cornerRadius: 8,
        font: .systemFont(ofSize: 16, weight: .medium),
        isEnabled: false
    )
    
    // MARK: - Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Initializations
    private func initViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash.fill"),
            style: .done,
            target: self,
            action: #selector(didTap)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red600
        
        view.backgroundColor = .background
        view.addSubviews(
            titleHeaderLabel,
            titleBackgroundView,
            descriptionHeaderLabel,
            descriptionBackgroundView,
            saveButton
        )
        titleBackgroundView.addSubviews(titlePlaceholderLabel, titleTextView)
        descriptionBackgroundView.addSubviews(descriptionPlaceholderLabel, descriptionTextView)
        
        saveButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            titleBackgroundView.topAnchor.constraint(equalTo: titleHeaderLabel.bottomAnchor, constant: 4),
            titleBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 128),
            
            titlePlaceholderLabel.topAnchor.constraint(equalTo: titleBackgroundView.topAnchor, constant: 8),
            titlePlaceholderLabel.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor, constant: 12),
            
            titleTextView.topAnchor.constraint(equalTo: titleBackgroundView.topAnchor),
            titleTextView.leadingAnchor.constraint(equalTo: titleBackgroundView.leadingAnchor, constant: 8),
            titleTextView.trailingAnchor.constraint(equalTo: titleBackgroundView.trailingAnchor),
            titleTextView.bottomAnchor.constraint(equalTo: titleBackgroundView.bottomAnchor),
            
            descriptionHeaderLabel.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 16),
            descriptionHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionBackgroundView.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 4),
            descriptionBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionBackgroundView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -8),
            
            descriptionPlaceholderLabel.topAnchor.constraint(equalTo: descriptionBackgroundView.topAnchor, constant: 8),
            descriptionPlaceholderLabel.leadingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: 12),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionBackgroundView.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionBackgroundView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: descriptionBackgroundView.bottomAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
    
    // MARK: - Functions
    func showData(todo: Todo?) {
        guard let todo else { return }
        self.todo = todo
        titleTextView.text = todo.title.orEmpty
        descriptionTextView.text = todo.desc.orEmpty
        
        titlePlaceholderLabel.isHidden = !titleTextView.text.isEmpty
        descriptionPlaceholderLabel.isHidden = !descriptionTextView.text.isEmpty
        saveButton.isEnabled = false
    }
    
    func checkSaveButtonAvailability() {
        if titleTextView.text != todo?.title ||
            descriptionTextView.text != todo?.desc {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @objc func didTap(_ sender: UIButton) {
        switch sender {
        case navigationItem.rightBarButtonItem:
            displayAlertMessage(
                messageToDisplay: "Are you sure you want to delete this task?"
            ) { [weak self] in
                guard let self else { return }
                guard let id = todo?.id else { return }
                presenter?.deleteTodo(id: id)
                NotificationCenter.default.post(name: NSNotification.Name("listUpdate"), object: nil)
                navigationController?.popViewController(animated: true)
            }
        case saveButton:
            guard let id = todo?.id else { return }
            save(by: id)
        default: break
        }
    }
    
    func save(by id: UUID) {
        let model = Todo(
            id: id,
            title: titleTextView.text,
            desc: descriptionTextView.text,
            createdAt: todo?.createdAt,
            updatedAt: Date().toFormattedString(),
            isCompleted: false
        )
        presenter?.updateTodo(todo: model)
        NotificationCenter.default.post(name: NSNotification.Name("listUpdate"), object: nil)
        todo = model
        saveButton.isEnabled = false
        displayAlertMessage(messageToDisplay: "Successfully updated!", title: "")
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        switch textView {
        case titleTextView:
            titlePlaceholderLabel.isHidden = !textView.text.isEmpty
        case descriptionTextView:
            descriptionPlaceholderLabel.isHidden = !textView.text.isEmpty
        default: break
        }
        checkSaveButtonAvailability()
    }
}
