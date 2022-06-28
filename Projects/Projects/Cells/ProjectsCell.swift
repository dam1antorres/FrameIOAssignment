//
//  ProjectsCell.swift
//  Projects
//
//  Created by Damian on 6/26/22.
//

import Foundation
import UIKit

class ProjectsCell: UITableViewCell {
    
    var viewModel: ProjectsCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private let projectNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let teamNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .lightGray
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let labelsStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2.0
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40.0),
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        [projectNameLabel, teamNameLabel].forEach { labelsStackView.addArrangedSubview($0) }
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        projectNameLabel.text = viewModel.projectName
        teamNameLabel.text = viewModel.teamName
    }
    
}
