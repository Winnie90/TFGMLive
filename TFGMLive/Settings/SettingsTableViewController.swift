import UIKit

class SettingsTableViewController: UITableViewController {
    
    var stations: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.value(forKey:"stations") as? Data {
            let decoder = PropertyListDecoder()
            stations = try! decoder.decode(Array<Station>.self, from: data)
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
        save()
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stations.remove(at: indexPath.row)
            save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func save() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(stations), forKey:"stations")
    }
}
