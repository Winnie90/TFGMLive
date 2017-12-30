import UIKit

class TramsCoordinator {
    
    var editButtonPressed: ()->() = {}
    
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
        let containingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainingViewController")  as! ContainingViewController
        containingViewController.station = station
        containingViewController.editButtonPressed = {
            self.editButtonPressed()
        }
        return containingViewController
    }
    
    
}
