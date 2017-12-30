import UIKit

class SettingsCoordinator {
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    func start() {
        let settingsTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsTableViewController")
        navigationController.viewControllers = [settingsTableViewController]
    }
}
