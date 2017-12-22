import UIKit

class SettingsTableViewController: UITableViewController {
    
    var stations: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let addStationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddStation") as! AddStationTableViewController
        addStationVC.stationSelected = { station in
            self.stations.append(station)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(addStationVC, animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(stations, forKey: "stations")
        dismiss(animated: true)
    }
}
