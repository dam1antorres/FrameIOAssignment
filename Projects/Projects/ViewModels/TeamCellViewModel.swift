//
//  TeamCellViewModel.swift
//  Projects
//
//  Created by Damian on 6/27/22.
//

import Foundation

class TeamCellViewModel {
    
    private let project: Project
    
    init(project: Project) {
        self.project = project
    }
    
    var projectName: String {
        project.attributes.name
    }
}
