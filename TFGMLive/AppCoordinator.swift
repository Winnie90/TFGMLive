
import UIKit

class AppCoordinator {
    
    let window: UIWindow
    let tramsCoordinator: TramsCoordinator
    let stationsService = StationServiceAdapter()
    
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
        settingsCoordinator.finish = { stations in
            StationServiceAdapter().saveUsersStationRecords(stations: stations)
            DispatchQueue.main.async {
                self.tramsCoordinator.start()
                self.navigationController.dismiss(animated: true)
            }
        }
        settingsCoordinator.start(stations: stationsService.getUsersStationRecords(),
                                  allStations: stationsService.getAllStationRecords())
        self.navigationController.present(settingsCoordinator.rootViewController, animated: true)
    }
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        for element in self {
            dict["\(selectKey(element))"] = "\(NSUUID().uuidString)" as AnyObject
        }
        return dict
    }
}
