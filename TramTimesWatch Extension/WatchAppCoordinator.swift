import Foundation
import WatchKit

class WatchAppCoordinator: WKInterfaceController, DataSourceChangedDelegate {
    
    
    let dataService = UserDataService()
    
    func setupInterfaces() {
        let stationIdentifiers = dataService.getStationIdentifiers()
        if stationIdentifiers.count > 0 {
            var interfaceControllers: [(name: String, context: AnyObject)] = []
            for identifier in stationIdentifiers {
                interfaceControllers.append((name: "StationInterfaceController", context: identifier as AnyObject))
            }
            WatchAppCoordinator.reloadRootControllers(withNamesAndContexts: interfaceControllers)
        } else {
            WatchSessionManager.sharedManager.updateData()
        }
    }
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        if dataService.updatedIdentifiers(stationIdentifiers: dataSource.stationIdentifiers) {
            setupInterfaces()
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        setupInterfaces()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
    }
}
