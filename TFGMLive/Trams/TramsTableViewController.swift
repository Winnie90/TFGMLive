import UIKit

class TramsTableViewController: UITableViewController {
    
    var station: StationPresentable?
    var refreshData: ()->() = {}
    var color: UIColor = UIColor.black
    
    public func dataRefreshed(station: StationPresentable, error: Error?) {
        if let error = error {
            showError(error: error)
        } 
        self.station = station
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
        tableView.register(UINib.init(nibName: "LargeTramTableViewCell", bundle: nil), forCellReuseIdentifier: "LargeTramTableViewCell")
        tableView.register(UINib.init(nibName: "MessageBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageBoardTableViewCell")
        refreshControl?.addTarget(self, action: #selector(refreshStation), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    @objc func refreshStation() {
        refreshData()
    }
    
    func applyStyles() {
        view.backgroundColor = self.color
        tableView.backgroundColor = self.color
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again, error code:\(error._code)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let station = station else {
            return 1
        }
        return station.trams.count > 0 ? station.trams.count+1 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let largeCell = tableView.dequeueReusableCell(withIdentifier: "LargeTramTableViewCell", for: indexPath) as? LargeTramTableViewCell
            if let station = station {
                largeCell?.stationNameLabel.text = station.name
                if station.trams.count > 0 {
                    let tram = station.trams[0]
                    largeCell?.destinationLabel.text = tram.destination
                    largeCell?.timeLabel.text = tram.waitTime
                } else {
                    largeCell?.timeLabel.text = "No Trams Due"
                }
                largeCell?.retrievedAtLabel.text = station.retrievedAt
            } else {
                largeCell?.stationNameLabel.text = ""
            }
            largeCell?.backgroundColor = color
            return largeCell!
        }
        if let station = station {
            if indexPath.row == station.trams.count {
                let messageBoardCell = tableView.dequeueReusableCell(withIdentifier: "MessageBoardTableViewCell", for: indexPath) as? MessageBoardTableViewCell
                messageBoardCell?.messageBoardLabel.text = station.messageBoard
                messageBoardCell?.backgroundColor = color
                return messageBoardCell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TramCell", for: indexPath)
                let tram = station.trams[indexPath.row]
                cell.textLabel?.text = tram.destination
                cell.detailTextLabel?.text = tram.waitTime
                cell.backgroundColor = color
                return cell
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 186
        } else if indexPath.row == station?.trams.count {
            return 100
        }
        return 80
    }
}

