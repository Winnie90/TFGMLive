import UIKit

class TramsTableViewController: UITableViewController {
    
    var station: StationPresentable?
    var refreshData: ()->() = {}
    
    public func dataRefreshed(station: StationPresentable) {
        self.station = station
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "LargeTramTableViewCell", bundle: nil), forCellReuseIdentifier: "LargeTramTableViewCell")
        refreshControl?.addTarget(self, action: #selector(refreshStation), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    @objc func refreshStation() {
        refreshData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let station = station else {
            return 1
        }
        return station.trams.count > 0 ? station.trams.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let station = station {
            if indexPath.row == 0 {
                let largeCell = tableView.dequeueReusableCell(withIdentifier: "LargeTramTableViewCell", for: indexPath) as? LargeTramTableViewCell
                largeCell?.stationNameLabel.text = station.name
                if station.trams.count > 0 {
                    let tram = station.trams[0]
                    largeCell?.destinationLabel.text = tram.destination
                    largeCell?.timeLabel.text = tram.waitTime
                } else {
                    largeCell?.timeLabel.text = "No Trams Due"
                }
                largeCell?.retrievedAtLabel.text = station.retrievedAt
                return largeCell!
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TramCell", for: indexPath)
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        
        if let station = station {
            let tram = station.trams[indexPath.row]
            cell.textLabel?.text = tram.destination
            cell.detailTextLabel?.text = tram.waitTime
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 186
        }
        return 60
    }
}

