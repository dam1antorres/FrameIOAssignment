//
//  Coordinator.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//

import Foundation
import UIKit

class Coordinator: Coordinating {

    private var contentViewController: UIViewController?
    private var mainNavigationController: UINavigationController? {
        return contentViewController as? UINavigationController
    }

    func launch(in window: UIWindow) {
        setupAppearance()
        contentViewController = UINavigationController(rootViewController: ProjectsViewController(viewModel: ProjectsViewModel(coordinator: self)))
        window.rootViewController = contentViewController
    }

    private func setupAppearance() {
        let navBarAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navBarAppearance.prefersLargeTitles = false
        navBarAppearance.isTranslucent = true
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navBarAppearance.barTintColor = .white
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backIndicatorImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
    }

}
