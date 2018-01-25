import UIKit

class SettingsCoordinator {
    
    private var stations: [StationRecord] = []
    
    typealias Response = (stations: [StationRecord], error: Error?)
    var finish: ([StationRecord])->() = {_ in }
    let stationsService: StationServiceAdapter
    
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
    
    init(stationsService: StationServiceAdapter){
        self.stationsService = stationsService
    }
    
    func start(stations: [StationRecord], coldStart: Bool) {
        self.stations = stations
        settingsTableViewController.dataRefreshed(stations: stations)
        settingsTableViewController.addStationsPressed = addStation
        settingsTableViewController.savePressed = save
        settingsTableViewController.deletedItem = { index in
            self.stations.remove(at: index)
        }
        navigationController.viewControllers = [settingsTableViewController]
        if coldStart {
            addStation()
        }
    }
    
    func addStation() {
        addStationsTableViewController.refreshData = {
            self.stationsService.getAllStationRecords(completion: { (stations, error) in
                self.addStationsTableViewController.dataRefreshed(
                    resultStations: stations,
                    error: error
                )
            })
        }
        addStationsTableViewController.stationSelected = { station in
            if !self.stations.contains(where: { stationArr in
                return station.identifier == stationArr.identifier
            }) {
                self.stations.append(station)
            }
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
