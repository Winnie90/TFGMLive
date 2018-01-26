import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var licenseTextArea: UITextView!
    @IBOutlet weak var dataHeader: UILabel!
    
    private var stations: [StationRecord] = []

    var addStationsPressed: ()->() = {}
    var deletedItem: (Int)->() = {_ in}
    var savePressed: ()->() = {}
    
    public func dataRefreshed(stations: [StationRecord]) {
        self.stations = stations
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibility()
        title = "Edit Stations"
        licenseTextArea.accessibilityTraits = UIAccessibilityTraitHeader
        licenseTextArea.text = "Contains Transport for Greater Manchester data\nhttps://developer.tfgm.com/\n\nIcons provided by Icons8\nhttps://icons8.com\n\nIcons made by Pixel perfect from Flaticon\nhttp://www.flaticon.com/authors/pixel-perfect"
        dataHeader.isAccessibilityElement = true
        dataHeader.accessibilityTraits = UIAccessibilityTraitHeader
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsStationCell", for: indexPath)
        let station = stations[indexPath.row]
        cell.accessibilityLabel = "added station"
        
        cell.textLabel?.text = station.name
        cell.textLabel?.isAccessibilityElement = true
        cell.textLabel?.accessibilityTraits = UIAccessibilityTraitNone
        cell.textLabel?.accessibilityLabel = "station name"
        cell.textLabel?.accessibilityValue = station.name
        
        cell.detailTextLabel?.text = "\(station.direction)\(station.destinations)"
        cell.detailTextLabel?.isAccessibilityElement = true
        cell.detailTextLabel?.accessibilityTraits = UIAccessibilityTraitNone
        cell.detailTextLabel?.accessibilityLabel = "station direction and destinations"
        cell.detailTextLabel?.accessibilityValue = "\(station.direction)\(station.destinations)"
        
        return cell
    }
    
    @IBAction func stationButtonPressed(_ sender: Any) {
        addStationsPressed()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        savePressed()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deletedItem(indexPath.row)
            self.stations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func setupAccessibility(){
        navigationItem.rightBarButtonItem?.accessibilityLabel = "Add a station"
    }
}
