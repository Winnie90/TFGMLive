import UIKit

struct Response: Decodable {
    let value: [Station]
}

class AddStationTableViewController: UITableViewController {
    
    var stationSelected: (Station) -> () = { _ in }
    var stations: [Station] = []
    var filteredStations: [Station] = []
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performRequest()
    }
    
    @objc func performRequest() {
        let path = Bundle.main.path(forResource: "stations", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url, options: .uncached)
        let parsedStationData = try? JSONDecoder().decode(Response.self, from: data)
        stations = (parsedStationData?.value)!
        stations = stations.filterDuplicates { (station1, station2) -> Bool in
            return station1.AtcoCode == station2.AtcoCode
            }.sorted(by: { (station1, station2) -> Bool in
                station1.StationLocation < station2.StationLocation
            })
        filteredStations = stations
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
        cell.textLabel?.text = station.StationLocation
        cell.detailTextLabel?.text = "towards \(station.Dest0)"
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
            return station.StationLocation.contains(searchText)
        })
        searchActive = filteredStations.count > 0
        tableView.reloadData()
    }
}


extension Array {
    
    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        var results = [Element]()
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}

