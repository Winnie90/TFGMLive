import UIKit

class TramsTableViewController: UITableViewController {
    
    var station: Station?
    var refreshData: ()->() = {}
    
    public func dataRefreshed(station: Station) {
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
            return 0
        }
        return station.trams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let station = station {
            if indexPath.row == 0 {
                let largeCell = tableView.dequeueReusableCell(withIdentifier: "LargeTramTableViewCell", for: indexPath) as? LargeTramTableViewCell
                largeCell?.stationNameLabel.text = station.name
                let tram = station.trams[0]
                largeCell?.destinationLabel.text = tram.destination
                largeCell?.timeLabel.text = tram.waitTime
                let dateString = DateFormatter.localizedString(from: station.retrievedAt, dateStyle: .none, timeStyle: .short)
                largeCell?.retrievedAtLabel.text = "Retrieved at \(dateString), pull down to refresh"
                return largeCell!
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TramCell", for: indexPath)
        let tram = station!.trams[indexPath.row]
        cell.textLabel?.text = tram.destination
        if let waitTime = Int(tram.waitTime) {
            let plural = waitTime > 1 ? "s" : ""
            cell.detailTextLabel?.text = "\(tram.waitTime) min\(plural)"
        } else {
            cell.detailTextLabel?.text = ""
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

