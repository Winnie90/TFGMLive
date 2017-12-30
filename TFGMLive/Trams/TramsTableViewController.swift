import UIKit

class TramsTableViewController: UITableViewController {
    
    var station: Station!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(performRequest), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performRequest()
    }

    @objc func performRequest() {
        let urlString = "https://api.tfgm.com/odata/Metrolinks(\(station.identifier))"
        guard let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedUrl) else {
                return
        }
        
        var request = URLRequest(url: url)
        request.setValue("fb7161bbf7754f188b7f849b69ce6fdd", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                self.showError()
            }
            if let data = data {
                self.station = try? JSONDecoder().decode(Station.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            } else {
                self.showError()
            }
        }.resume()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.station.trams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TramCell", for: indexPath)
        let tram = self.station.trams[indexPath.row]
        cell.textLabel?.text = tram.destination
        if let waitTime = Int(tram.waitTime) {
            let plural = waitTime > 1 ? "s" : ""
            cell.detailTextLabel?.text = "\(tram.waitTime) minute\(plural) to go"
        } else {
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
}

