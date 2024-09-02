//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 02.09.24.
//

import UIKit

protocol AddTaskViewProtocol: AnyObject {
}

class AddTaskViewController: UIViewController, AddTaskViewProtocol {
    // MARK: - Variables
    var presenter: AddTaskPresenterProtocol?
    
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
    private let createButton = BaseButton(
        title: "Create task",
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
    }
    
    // MARK: - Initializations
    private func initViews() {
        view.backgroundColor = .background
        view.addSubviews(
            titleHeaderLabel,
            titleBackgroundView,
            descriptionHeaderLabel,
            descriptionBackgroundView,
            createButton
        )
        titleBackgroundView.addSubviews(titlePlaceholderLabel, titleTextView)
        descriptionBackgroundView.addSubviews(descriptionPlaceholderLabel, descriptionTextView)
        
        createButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
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
            descriptionBackgroundView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -8),
            
            descriptionPlaceholderLabel.topAnchor.constraint(equalTo: descriptionBackgroundView.topAnchor, constant: 8),
            descriptionPlaceholderLabel.leadingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: 12),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionBackgroundView.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionBackgroundView.leadingAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionBackgroundView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: descriptionBackgroundView.bottomAnchor),
            
            createButton.heightAnchor.constraint(equalToConstant: 48),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
    
    // MARK: - Functions
    func checkSaveButtonAvailability() {
        createButton.isEnabled = !titleTextView.text.isEmpty
    }
    
    @objc func didTap(_ sender: UIButton) {
        let model = Todo(
            id: UUID(),
            title: titleTextView.text,
            desc: descriptionTextView.text,
            createdAt: Date().toFormattedString(),
            updatedAt: Date().toFormattedString(),
            isCompleted: false
        )
        presenter?.saveTask(todo: model)
        NotificationCenter.default.post(name: NSNotification.Name("listUpdate"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}

extension AddTaskViewController: UITextViewDelegate {
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
