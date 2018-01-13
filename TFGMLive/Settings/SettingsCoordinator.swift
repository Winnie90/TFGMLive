import UIKit

class SettingsCoordinator {
    
    private var stations: [StationRecord] = []
    private var allStations: [StationRecord] = []
    
    var finish: ([StationRecord])->() = {_ in }
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    private lazy var settingsTableViewController: SettingsTableViewController = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
    }()
    
    private lazy var addStationsTableViewController: AddStationTableViewController = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddStation") as! AddStationTableViewController
    }()
    
    func start(stations: [StationRecord], allStations: [StationRecord]) {
        self.stations = stations
        self.allStations = allStations
        settingsTableViewController.dataRefreshed(stations: stations)
        settingsTableViewController.addStationsPressed = addStation
        settingsTableViewController.savePressed = save
        settingsTableViewController.deletedItem = { index in
            self.stations.remove(at: index)
        }
        navigationController.viewControllers = [settingsTableViewController]
    }
    
    func addStation() {
        addStationsTableViewController.stations = allStations
        addStationsTableViewController.stationSelected = { station in
            self.stations.append(station)
            self.settingsTableViewController.dataRefreshed(stations: self.stations)
            self.navigationController.popToRootViewController(animated: true)
        }
        navigationController.pushViewController(addStationsTableViewController, animated: true)
    }
    
    func save() {
        finish(stations)
    }
    
    func noStationsError() {
        let ac = UIAlertController(title: "No Stations", message: "Please add at least one station", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        navigationController.viewControllers.first?.present(ac, animated: true)
    }
}
