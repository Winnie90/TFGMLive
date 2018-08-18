import UIKit
import StationRequest

class TramsCoordinator {
    
    var editButtonPressed: (Bool)->() = {_ in}
    
    let stationService: StationServiceAdapter
    
    init(stationService: StationServiceAdapter) {
        self.stationService = stationService
    }
    
    var rootViewController: UIViewController {
        return pageViewController
    }
    
    private var pageViewController: PageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
    
    func start() {
        let vcs = viewControllers()
        pageViewController.orderedViewControllers = vcs
        if let viewController = vcs.first {
            pageViewController.setViewControllers([viewController],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
        }
        pageViewController.editButtonPressed = editButtonPressed
    }
    
    private func viewControllers() -> [UIViewController] {
        let stations: [StationPresentable] = stationService.getUserStations()
        var viewControllers: [UIViewController] = []
        for (key, station) in stations.enumerated() {
            viewControllers.append(newTramViewController(station: station, color: ColorConverter.colorFor(index: key)))
        }
        return viewControllers
    }
    
    private func newTramViewController(station: StationPresentable, color: UIColor) -> UIViewController {
        let tramsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TramsTableViewController") as! TramsTableViewController
        tramsViewController.refreshData = {
            self.stationService.getLatestDataForStation(station: station, completion: { station, error in
                tramsViewController.dataRefreshed(station: station, error: error)
            })
        }
        tramsViewController.color = color
        return tramsViewController
    }
    
    public func moveToIndex(_ index: Int) -> Bool {
        let vcs = viewControllers()
        if index < vcs.count {
            pageViewController.orderedViewControllers = vcs
            pageViewController.setViewControllers([vcs[index]],
                                                  direction: .forward,
                                                  animated: true,
                                                  completion: nil)
            return true
        }
        return false
    }
    
    public func moveToIdentifier(_ identifier: Int) -> Bool {
        let stations: [StationPresentable] = stationService.getUserStations()
        guard let index = stations.index(where: {
            $0.identifier == identifier
        }) else { return false }
        return moveToIndex(index)
    }
    

}
