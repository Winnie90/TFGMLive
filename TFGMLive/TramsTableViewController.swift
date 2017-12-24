import UIKit

class TramsTableViewController: UITableViewController {
    
    var trams: [Tram] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(performRequest), for: UIControlEvents.valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performRequest()
    }

    @objc func performRequest() {
        var requestId = 1
        var stations: [Station] = []
        do {
            let data = UserDefaults.standard.value(forKey:"stations") as? Data
            let decoder = PropertyListDecoder()
            stations = try decoder.decode(Array<Station>.self, from: data!)
            
        } catch {
            print(error.localizedDescription)
        }
        if let requestIdentifier = stations.first?.identifier {
            requestId = requestIdentifier
        }
        let urlString = "https://api.tfgm.com/odata/Metrolinks(\(requestId))"
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
            if let data = data,
                let station = try? JSONDecoder().decode(Station.self, from: data) {
                self.trams = station.trams
                DispatchQueue.main.async {
                    self.title = station.name
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
        return trams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TramCell", for: indexPath)
        let tram = trams[indexPath.row]
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

