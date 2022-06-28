//
//  ProjectsViewModel.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation

class ProjectsViewModel: ViewModel {
    
    private let api = API()
    @Published var projects: [Project] = []
    @Published var teams: [TeamInfo] = []
    @Published var fetchError: Error?
    
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
        let project = recentProjects[index]
        let team = teams.filter { $0.id == project.relationships.team.id }.first
        return ProjectsCellViewModel(project: project, team: team)
    }
    
    func getCellViewModelForTeam(_ section: Int,_ index: Int) -> TeamCellViewModel {
        let projects = getProjectsFromTeam(section)
        return TeamCellViewModel(project: projects[index])
    }
    
    var recentTitle: String? {
        recentProjects.count != 0 ? "Recents" : nil
    }
    
    var numberOfSections: Int {
        let recents = recentProjects.count != 0 ? 1 : 0
        return recents + teams.count
    }
    
    var recentProjects: [Project] {
        switch projects.count {
        case 0..<5:
            return []
        case 5..<10:
            let numberOfItems = projects.count - 6
            let sortedProjectsByDate = Array(projects.sorted { $0.attributes.updated_at.compare($1.attributes.updated_at) == .orderedDescending }[...numberOfItems])
            return sortedProjectsByDate
        case 10...:
            let sortedProjectsByDate = Array(projects.sorted { $0.attributes.updated_at.compare($1.attributes.updated_at) == .orderedDescending }[0...4])
            return sortedProjectsByDate
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
