//
//  TeamInfo.swift
//  Projects
//
//  Created by Damian on 6/27/22.
//

import Foundation

struct TeamInfo: Decodable {
    let id: String
    let attributes: TeamAttributes
    let type: ProjectType
}

struct TeamAttributes: Decodable {
    let name: String
}
