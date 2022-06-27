//
//  ProjectsViewController.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation
import UIKit

class ProjectsViewController: BaseViewController {
    
    private let projectsViewModel: ProjectsViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(cellType: TopicCell.self)
//        tableView.register(headerFooterViewType: TopicsTableViewHeader.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isHidden = true
        return tableView
    }()
    
    init(viewModel: ProjectsViewModel) {
        self.projectsViewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
        projectsViewModel.fetchProjects()
        loading = true
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .blue
    }
    
    private func setupBindings() {
        projectsViewModel.$projects
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] projects in
                print("==== projects: \(projects)")
                self?.tableView.isHidden = false
                self?.loading = false
            })
            .store(in: &bag)
    }
    
}
