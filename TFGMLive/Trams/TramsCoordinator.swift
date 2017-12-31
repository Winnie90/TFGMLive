import UIKit

class TramsCoordinator {
    
    var editButtonPressed: ()->() = {}
    private var stationService = StationService()
    
    var rootViewController: UIViewController {
        return pageViewController
    }
    
    private var pageViewController: PageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController")  as! PageViewController
    
    func start() {
        pageViewController.orderedViewControllers = orderedViewControllers
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        var stations: [Station] = []
        do {
            if let data = UserDefaults.standard.value(forKey:"stations") as? Data {
                stations = try PropertyListDecoder().decode(Array<Station>.self, from: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        if stations.count == 0 {
            stations = [Station(identifier: 1,
                                stationUid: "",
                                name: "Media City UK",
                                trams: [])]
        }
        var viewControllers: [UIViewController] = []
        for station in stations {
            viewControllers.append(newTramViewController(station: station))
        }
        return viewControllers
    }()
    
    private func newTramViewController(station: Station) -> UIViewController {
        let tramsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TramsTableViewController") as! TramsTableViewController
        tramsViewController.refreshData = {
            self.stationService.retrieveStationData(identifier: station.identifier, completion: { station in
                tramsViewController.dataRefreshed(station: station)
            })
        }
        return tramsViewController
    }
    
}
