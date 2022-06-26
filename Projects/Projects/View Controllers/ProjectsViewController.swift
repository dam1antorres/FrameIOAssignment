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
    
    init(viewModel: ProjectsViewModel) {
        self.projectsViewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupSubviews()
        setupBindings()
        projectsViewModel.fetchProjects()
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupBindings() {
        projectsViewModel.$projects
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { projects in
                print("==== projects: \(projects)")
            })
            .store(in: &bag)
    }
    
}
