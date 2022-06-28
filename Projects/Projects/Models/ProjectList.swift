//
//  ProjectList.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation

struct ProjectList: Decodable {
    let data: [Project]
    let teams: [TeamInfo]
    
    public enum CodingKeys: String, CodingKey {
        case data
        case included
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decode([Project].self, forKey: .data)
        teams = try values.decode([TeamInfo].self, forKey: .included)
    }
}
