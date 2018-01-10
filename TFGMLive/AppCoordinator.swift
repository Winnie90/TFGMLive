import UIKit
import Firebase

class AppCoordinator {
    
    let window: UIWindow
    let tramsCoordinator: TramsCoordinator
    let stationsService = StationServiceAdapter()
    var dynamicLinksUpdated: ([UIApplicationShortcutItem])->() = { _ in }
    
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
    
    private func setupAnalytics() {
        FirebaseApp.configure()
    }
    
    private func setupWatchConnection() {
        WatchSessionManager.sharedManager.startSession()
    }
    
    private func setupNavigation() {
        tramsCoordinator.editButtonPressed = editTrams
        tramsCoordinator.start()
        navigationController.viewControllers = [tramsCoordinator.rootViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func editTrams() {
        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.finish = { stations in
            self.stationsService.saveUsersStationRecords(stations: stations)
            self.dynamicLinksUpdated(self.createShortcutItems(stations: stations))
            DispatchQueue.main.async {
                self.tramsCoordinator.start()
                self.navigationController.dismiss(animated: true)
            }
        }
        settingsCoordinator.start(stations: stationsService.getUsersStationRecords(),
                                  allStations: stationsService.getAllStationRecords())
        self.navigationController.present(settingsCoordinator.rootViewController, animated: true)
    }
    
    private func createShortcutItems(stations: [StationRecord])->([UIApplicationShortcutItem]) {
        var shortcutItems: [UIApplicationShortcutItem] = []
        for (i, station) in stations.enumerated() {
            let shortcutItem = UIApplicationShortcutItem(type: "\(i)", localizedTitle: station.name, localizedSubtitle: "\(station.destination)", icon: nil, userInfo: nil)
            shortcutItems.append(shortcutItem)
        }
        return shortcutItems
    }
    
    public func handleShortcut(shortcutItem: UIApplicationShortcutItem) -> Bool {
        guard let shortcutIndex = Int(shortcutItem.type) else { return false }
        return tramsCoordinator.moveToIndex(shortcutIndex)
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
