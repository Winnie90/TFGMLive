import UIKit

class PageViewController: UIPageViewController {

    var stations: [Station] = []
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        view.addSubview(pageControl)
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        do {
            if let data = UserDefaults.standard.value(forKey:"stations") as? Data {
                let decoder = PropertyListDecoder()
                stations = try decoder.decode(Array<Station>.self, from: data)
            } else {
                stations = [Station(identifier: 1,
                                    stationUid: "",
                                    name: "Media City UK",
                                    trams: [])]
            }
            
        } catch {
            print(error.localizedDescription)
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
        return containingViewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if orderedViewControllers.count == 1 {
            return nil
        }
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if orderedViewControllers.count == 1 {
            return nil
        }
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }

}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
}
