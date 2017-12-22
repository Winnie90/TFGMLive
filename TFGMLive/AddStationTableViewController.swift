import UIKit

struct Response: Decodable {
    let value: [Station]
}

class AddStationTableViewController: UITableViewController {
    
    var stations: [Station] = []
    
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.StationLocation
        cell.detailTextLabel?.text = "towards \(station.Dest0)"
        return cell
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

