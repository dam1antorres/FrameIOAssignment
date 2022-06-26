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
    @Published var fetchError: Error?
    
    func fetchProjects() {
        Task {
            do {
                let data = try await api.fetchProjects()
                self.projects = data
            } catch {
                self.fetchError = error
            }
        }
    }
}
