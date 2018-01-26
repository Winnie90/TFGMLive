import UIKit

class AddStationTableViewController: UITableViewController {
    
    var stationSelected: (StationRecord) -> () = { _ in }
    var stations: [StationRecord] = []
    var filteredStations: [StationRecord] = []
    var searchActive = false
    var refreshData: ()->() = {}
    
    public func dataRefreshed(resultStations: [StationRecord], error: Error?) {
        if let error = error {
            showError(error: error)
        }
        stations = resultStations
        filteredStations = resultStations
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchActive = false
        filteredStations = stations
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredStations.count
        }
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
        let station = searchActive ? filteredStations[indexPath.row] : stations[indexPath.row]
        cell.accessibilityLabel = "station"
        cell.textLabel?.text = "\(station.name)"
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = searchActive ? filteredStations[indexPath.row] : stations[indexPath.row]
        stationSelected(station)
        navigationController?.popViewController(animated: true)
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again, error code:\(error._code)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AddStationTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStations = stations.filter({ station in
            return station.name.lowercased().contains(searchText.lowercased())
        })
        searchActive = filteredStations.count > 0
        tableView.reloadData()
    }
}
