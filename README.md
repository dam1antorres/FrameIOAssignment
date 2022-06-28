# FrameIOAssignment

In this exercise, there is not that much use for the `Coordinator` mostly for launching the `rootViewController`. In case the app has more flows to go to, this coordinator will handle said flows. Here is an example:

```
enum Segue {
  case projectDetails(ProjectDetailsSegue)
}

enum ProjectDetailsSegue {
  case details(project: Project, team: TeamInfo)
}

protocol Coordinating {
  func handleSegue(_ segue: Segue)
}

class Coordinator {
  func handleSegue(_ segue) {
    switch segue {
      case .projectDetails(let segue): handleProjectDetailsSegue(segue)
    }
  }
  
  private func handleProjectDetailsSegue {
    switch segue {
    case details(let project, let teamInfo): showDetailProjectScreen(project, teamInfo)
    }
  }
  
  private func showDetailsProjectScreen(_ project: Project, _ teamInfo: TeamInfo) {
    let viewModel = DetailProjectViewModel(project, teamInfo, self)
    let viewController = DetailProjectViewController(viewModel: viewModel)
    mainNavigationController.pushViewController(viewController, animated: true)
  }
  
}
```
