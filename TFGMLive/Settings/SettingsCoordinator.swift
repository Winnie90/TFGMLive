import UIKit

class SettingsCoordinator {
    
    private var stations: [Station] = []
    
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
    
    func start() {
        if let data = UserDefaults.standard.value(forKey:"stations") as? Data {
            let decoder = PropertyListDecoder()
            stations = try! decoder.decode(Array<Station>.self, from: data)
        }
        
        settingsTableViewController.dataRefreshed(stations: stations)
        settingsTableViewController.addStationsPressed = addStation
        settingsTableViewController.savePressed = save
        settingsTableViewController.deletedItem = { index in
            self.stations.remove(at: index)
        }
        navigationController.viewControllers = [settingsTableViewController]
    }
    
    func addStation() {
        addStationsTableViewController.stationSelected = { station in
            self.stations.append(station)
            self.settingsTableViewController.dataRefreshed(stations: self.stations)
            self.navigationController.popToRootViewController(animated: true)
        }
        navigationController.pushViewController(addStationsTableViewController, animated: true)
    }
    
    func save() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(stations), forKey:"stations")
        navigationController.dismiss(animated: true)
    }
}
