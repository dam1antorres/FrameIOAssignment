//
//  TeamCell.swift
//  Projects
//
//  Created by Damian on 6/27/22.
//

import Foundation
import UIKit

class TeamProjectCell: UITableViewCell {
    
    var viewModel: TeamCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 40.0),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        label.text = viewModel.projectName
    }
    
    override func prepareForReuse() {
        label.text = ""
    }
    
}
