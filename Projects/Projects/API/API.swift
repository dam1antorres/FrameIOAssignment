//
//  API.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation

class API {

    enum APIError: LocalizedError {
        case invalidUrl
        case unknownError
    }

    struct Constants {
        static let projects = "https://frameio-swift-exercise.herokuapp.com/projects?include=team"
    }


    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    

    func fetchProjects() async throws -> ProjectList {
        guard let url = URL(string: Constants.projects) else {
            throw APIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let status = (response as? HTTPURLResponse)?.statusCode
        
        if let status = status, (200..<300).contains(status) {
            let topicList = try decoder.decode(ProjectList.self, from: data)
            return topicList
        } else {
            throw APIError.unknownError
        }
    }

}
