import UIKit
import Firebase

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
        
        tramsCoordinator = TramsCoordinator(stationService: stationsService)

        setupAnalytics()
        setupWatchConnection()
        setupNavigation()
    }
    
    func setupAnalytics() {
        FirebaseApp.configure()
    }
    
    func setupWatchConnection() {
        WatchSessionManager.sharedManager.startSession()
    }
    
    func setupNavigation() {
        tramsCoordinator.editButtonPressed = editTrams
        tramsCoordinator.start()
        navigationController.viewControllers = [tramsCoordinator.rootViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func editTrams() {
        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.finish = { stations in
            self.stationsService.saveUsersStationRecords(stations: stations)
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
