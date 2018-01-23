import UIKit

class AddStationTableViewController: UITableViewController {
    
    var stationSelected: (StationRecord) -> () = { _ in }
    var stations: [StationRecord] = []
    var filteredStations: [StationRecord] = []
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredStations = stations
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchActive = false
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
        cell.textLabel?.text = station.name
        cell.detailTextLabel?.text = "towards \(station.destination)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = searchActive ? filteredStations[indexPath.row] : stations[indexPath.row]
        stationSelected(station)
        navigationController?.popViewController(animated: true)
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
