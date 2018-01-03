import Foundation
import WatchKit

class WatchAppCoordinator: WKInterfaceController {
    
    let dataService = UserDataService()
    
    func setupInterfaces() {
        let stationIdentifiers = dataService.getStationIdentifiers()
        if stationIdentifiers.count > 0 {
            var interfaceControllers: [(name: String, context: AnyObject)] = []
            for identifier in stationIdentifiers {
                interfaceControllers.append((name: "StationInterfaceController", context: identifier as AnyObject))
            }
            WatchAppCoordinator.reloadRootControllers(withNamesAndContexts: interfaceControllers)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupInterfaces()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
