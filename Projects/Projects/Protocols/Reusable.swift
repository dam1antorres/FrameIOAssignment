//
//  Reusable.swift
//  Projects
//
//  Created by Damian on 6/26/22.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
