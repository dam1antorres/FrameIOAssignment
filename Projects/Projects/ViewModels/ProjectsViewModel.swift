//
//  ProjectsViewModel.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation

class ProjectsViewModel: ViewModel {
    
    let api = API()
    @Published var projects: [Project] = []
    @Published var teams: [TeamInfo] = []
    @Published var fetchError: Error?
    
    private var teamDirectory: [String: TeamInfo] {
        var directory: [String: TeamInfo] = [String: TeamInfo]()
        teams.forEach { directory[$0.id] = $0 }
        return directory
    }
    
    func fetchProjects() {
        Task {
            do {
                let projectList = try await api.fetchProjects()
                self.projects = projectList.data
                self.teams = projectList.teams
            } catch {
                self.fetchError = error
            }
        }
    }
    
    func getCellViewModelFor(_ index: Int) -> ProjectsCellViewModel  {
        let project = projects[index]
        let team = teamDirectory[project.relationships.team.id]
        return ProjectsCellViewModel(project: project, team: team)
    }
    
    func getCellViewModelForTeam(_ section: Int,_ index: Int) -> TeamCellViewModel {
        let projects = getProjectsFromTeam(section)
        return TeamCellViewModel(project: projects[index])
    }
    
    var recentTitle: String? {
        recentProjects.count != 0 ? "Recents" : nil
    }
    
    var recentProjects: [Project] {
        switch projects.count {
        case 0..<5:
            return []
        case 5..<10:
            let numberOfItems = projects.count - 5
            return Array(projects[...numberOfItems])
        case 10...:
            return Array(projects[0...4])
        default:
            return []
        }
    }
    
    func getTeamNameForSection(_ section: Int) -> String {
        let index = recentProjects.count != 0 ? 1 : 0
        return teams[section - index].attributes.name
    }
    
    func getProjectsFromTeam(_ section: Int) -> [Project] {
        let index = recentProjects.count != 0 ? 1 : 0
        return projects.filter { $0.relationships.team.id == teams[section - index].id }
    }
}
