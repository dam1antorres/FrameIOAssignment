//
//  Project.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation

enum ProjectType: String, Decodable {
    case projects, teams
}

struct Project: Decodable {
    let id: String
    let attributes: ProjectAtrributes
    let relationships: ProjectRelationship
    let type: ProjectType
}

struct ProjectAtrributes: Decodable {
    let name: String
//    let updated_at: Date
}

struct ProjectRelationship: Decodable {
    let team: Team
}

struct Team: Decodable {
    let id: String
    let type: ProjectType
}
