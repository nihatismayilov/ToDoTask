//
//  TodoTableViewCell.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 01.09.24.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func markAsComplete(_ cell: TodoTableViewCell, isCompleted: Bool)
}

class TodoTableViewCell: UITableViewCell {
    // MARK: - Variables
    weak var delegate: TodoTableViewCellDelegate?
    
    // MARK: - UI Components
    private lazy var mainStackView = UIStackView(
        axis: .horizontal,
        alignment: .center,
        distribution: .equalSpacing,
        spacing: 8
    )
    private lazy var completionButton = BaseButton(
        image: .icCheckbox,
        tintColor: .red700
    )
    private lazy var labelStack = UIStackView(
        axis: .vertical,
        alignment: .leading,
        distribution: .equalSpacing,
        spacing: 4
    )
    private lazy var titleLabel = UILabel(
        textColor: .primaryText,
        font: .systemFont(ofSize: 16, weight: .semibold)
    )
    private lazy var dateLabel = UILabel(
        textColor: .secondaryText,
        font: .systemFont(ofSize: 14)
    )
    
    // MARK: - Parent Delegations
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        selectionStyle = .none
        backgroundColor = .clear
        setupView()
    }
    
    // MARK: - Functions
    private func setupView() {
        contentView.addSubviews(mainStackView)
        mainStackView.addArrangedSubviews(completionButton, labelStack)
        labelStack.addArrangedSubviews(titleLabel, dateLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        completionButton.setImage(.icCheckbox, for: .normal)
        completionButton.setImage(.icCheckboxFilled, for: .selected)
        completionButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    func setupCellWith(data: Todo) {
        titleLabel.text = data.title
        dateLabel.text = data.updatedAt
        completionButton.isSelected = data.isCompleted ?? false
        
        var attributedTitle = NSMutableAttributedString(string: data.title ?? "")
        attributedTitle.addAttributes([.strikethroughStyle: 0], range: NSRange(location: 0, length: attributedTitle.length))
        
        if data.isCompleted ?? false {
            attributedTitle.addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: attributedTitle.length))
        }
        
        titleLabel.attributedText = attributedTitle
    }
    
    @objc func didTap(_ sender: UIButton) {
        completionButton.isSelected.toggle()
        delegate?.markAsComplete(self, isCompleted: completionButton.isSelected)
    }
}
