
import UIKit

class AppCoordinator {
    
    let window: UIWindow
    let tramsCoordinator: TramsCoordinator
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    public init(window: UIWindow) {
        self.window = window
        
        tramsCoordinator = TramsCoordinator()
        tramsCoordinator.editButtonPressed = editTrams
        tramsCoordinator.start()
        navigationController.viewControllers = [tramsCoordinator.rootViewController]
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func editTrams() {
        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.finish = {
            DispatchQueue.main.async {
                self.tramsCoordinator.start()
                self.navigationController.dismiss(animated: true)
            }
        }
        settingsCoordinator.start()
        self.navigationController.present(settingsCoordinator.rootViewController, animated: true)
    }
}
