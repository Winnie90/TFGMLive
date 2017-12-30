import UIKit

class SettingsTableViewController: UITableViewController {
    
    private var stations: [Station] = []

    var addStationsPressed: ()->() = {}
    var deletedItem: (Int)->() = {_ in}
    var savePressed: ()->() = {}
    
    public func dataRefreshed(stations: [Station]) {
        self.stations = stations
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsStationCell", for: indexPath)
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.name
        if let destination = station.trams.first?.destination {
            cell.detailTextLabel?.text = "towards \(destination)"
        } else {
            cell.detailTextLabel?.text = ""
        }
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
}