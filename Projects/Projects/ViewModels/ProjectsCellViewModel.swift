//
//  ProjectsCellViewModel.swift
//  Projects
//
//  Created by Damian on 6/27/22.
//

import Foundation

class ProjectsCellViewModel {
    
    private let project: Project?
    private let teamInfo: TeamInfo?
    
    init(project: Project?, team: TeamInfo?) {
        self.project = project
        self.teamInfo = team
    }
    
    var projectName: String? {
        project?.attributes.name
    }
    
    var teamName: String? {
        teamInfo?.attributes.name
    }
    
}
