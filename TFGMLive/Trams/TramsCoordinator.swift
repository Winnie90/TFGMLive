import UIKit

class TramsCoordinator {
    
    var editButtonPressed: ()->() = {}
    
    let stationService: StationServiceAdapter
    
    init(stationService: StationServiceAdapter) {
        self.stationService = stationService
    }
    
    var rootViewController: UIViewController {
        return pageViewController
    }
    
    private var pageViewController: PageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController")  as! PageViewController
    
    func start() {
        pageViewController.orderedViewControllers = viewControllers()
        pageViewController.editButtonPressed = editButtonPressed
    }
    
    private func viewControllers() -> [UIViewController] {
        let stations: [StationPresentable] = stationService.getUserStations()
        var viewControllers: [UIViewController] = []
        for station in stations {
            viewControllers.append(newTramViewController(station: station))
        }
        return viewControllers
    }
    
    private func newTramViewController(station: StationPresentable) -> UIViewController {
        let tramsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TramsTableViewController") as! TramsTableViewController
        tramsViewController.refreshData = {
            self.stationService.getLatestDataForStation(station: station, completion: { station in
                tramsViewController.dataRefreshed(station: station)
            })
        }
        return tramsViewController
    }
    
}
