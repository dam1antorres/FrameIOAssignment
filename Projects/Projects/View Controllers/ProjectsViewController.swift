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
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectsCell.self, forCellReuseIdentifier: ProjectsCell.reuseIdentifier)
        tableView.register(TeamProjectCell.self, forCellReuseIdentifier: TeamProjectCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 50.0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
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
        title = "Projects"
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupBindings() {
        projectsViewModel.$projects
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] projects in
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                self?.loading = false
            })
            .store(in: &bag)
    }
    
}

extension ProjectsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return projectsViewModel.recentTitle
        case 1...:
            return projectsViewModel.getTeamNameForSection(section)
        default: return nil
        }
    }
}

extension ProjectsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProjectsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = projectsViewModel.getCellViewModelFor(indexPath.row)
            return cell
        case 1...:
            let cell: TeamProjectCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = projectsViewModel.getCellViewModelForTeam(indexPath.section, indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let recents = projectsViewModel.recentProjects.count != 0 ? 1 : 0
        return recents + projectsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return projectsViewModel.recentProjects.count
        case 1...:
            return projectsViewModel.getProjectsFromTeam(section).count
        default: return 0
        }
    }
    
}
