import UIKit

class ContainingViewController: UIViewController {

    var station: Station!
    var editButtonPressed: ()->() = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tramsTableViewController = childViewControllers.first as! TramsTableViewController
        tramsTableViewController.station = station
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        editButtonPressed()
    }
    
}
