import UIKit
import Firebase
import CoreSpotlight

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
        coldStartCheck()
        indexStations()
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
    
    private func coldStartCheck() {
        if stationsService.getUsersStationRecords().count < 1 {
            editTrams(coldStart: true)
        }
    }
    
    private func indexStations() {
        stationsService.getAllStationRecords(completion: { (stations, error) in
            StationIndexer.index(stations: stations)
        })
    }
    
    private func editTrams(coldStart: Bool = false) {
        let settingsCoordinator = SettingsCoordinator(stationsService: stationsService)
        settingsCoordinator.finish = { stations in
            if stations.count > 0 {
                if self.stationsService.saveUsersStationRecords(stations: stations) {
                    self.dynamicLinksUpdated(self.createShortcutItems(stations: stations))
                    self.tramsCoordinator.start()
                }
                DispatchQueue.main.async {
                    self.navigationController.dismiss(animated: true)
                }
            } else {
                settingsCoordinator.noStationsError()
            }
        }
        settingsCoordinator.start(stations: stationsService.getUsersStationRecords(),
                                  coldStart: coldStart)
        self.navigationController.present(settingsCoordinator.rootViewController, animated: true)
    }
    
    private func createShortcutItems(stations: [StationRecord])->([UIApplicationShortcutItem]) {
        var shortcutItems: [UIApplicationShortcutItem] = []
        for (i, station) in stations.enumerated() {
            let shortcutItem = UIApplicationShortcutItem(type: "\(i)", localizedTitle: station.name, localizedSubtitle: "\(station.direction)\(station.destinations)", icon: UIApplicationShortcutIcon(templateImageName:"shortcutIcon"), userInfo: nil)
            shortcutItems.append(shortcutItem)
        }
        return shortcutItems
    }
    
}

extension AppCoordinator {
    public func handleShortcut(shortcutItem: UIApplicationShortcutItem) -> Bool {
        guard let shortcutIndex = Int(shortcutItem.type) else { return false }
        return tramsCoordinator.moveToIndex(shortcutIndex)
    }
    
    public func handleUserActivity(_ userActivity: NSUserActivity) {
        if userActivity.activityType == CSSearchableItemActionType {
            if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String,
                let ident = Int(uniqueIdentifier) {
                    if !tramsCoordinator.moveToStation(identifier: ident) {
                        tramsCoordinator.addStation(identifier: ident, completion: {
                            _ = self.tramsCoordinator.moveToStation(identifier: ident)
                        })
                    }
            }
        }
    }
}

extension AppCoordinator {
    @available(iOS 12.0, *)
    public func handle(identifier: String) -> Bool {
        let intIdent = Int(identifier) ?? 0
        let index = stationsService.getUserStations().index(where: { (station) -> Bool in
            station.identifier == intIdent
        })
        return tramsCoordinator.moveToIndex(index ?? 0)
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
