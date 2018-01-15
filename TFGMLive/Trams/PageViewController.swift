import UIKit

class PageViewController: UIPageViewController {

    var orderedViewControllers: [UIViewController] = []
    var pageControl = UIPageControl()
    var editButtonPressed: (Bool)->() = {_ in}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0) //blue
        createPageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePageControl()
    }
    
    func createPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 42,width: UIScreen.main.bounds.width,height: 42))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        let editButton = UIButton(type: .custom)
        editButton.frame = CGRect(x: UIScreen.main.bounds.maxX - 42, y: 0, width: 34, height: 34)
        editButton.setImage(UIImage(named: "settings"), for: .normal)

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        pageControl.addSubview(editButton)
        
        view.addSubview(pageControl)
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
    }
    
    @objc func editButtonTapped() {
        editButtonPressed(false)
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
        if let currentPage = orderedViewControllers.index(of: pageContentViewController) {
            pageControl.currentPage = currentPage
        } else {
            pageControl.currentPage = 0
        }
    }
}
