import UIKit

struct Station: Decodable {
    let StationLocation: String
    let Dest0: String
    let Wait0: String
    let Dest1: String
    let Wait1: String
    let Dest2: String
    let Wait2: String
    let Dest3: String
    let Wait3: String
}

struct Tram {
    let destination: String
    let waitTime: String
}

class TableViewController: UITableViewController {
    
    var station = Station(StationLocation: "",
                          Dest0: "", Wait0: "",
                          Dest1: "", Wait1: "",
                          Dest2: "", Wait2: "",
                          Dest3: "", Wait3: "")
    var trams: [Tram] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performRequest()
        
        refreshControl?.addTarget(self, action: #selector(performRequest), for: UIControlEvents.valueChanged)
    }
    
    @objc func performRequest() {
        let urlString = "https://api.tfgm.com/odata/Metrolinks(1)"
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
                let parsedStationData = try? JSONDecoder().decode(Station.self, from: data) {
                self.station = parsedStationData
                self.trams = [
                    Tram(destination: self.station.Dest0, waitTime: self.station.Wait0),
                    Tram(destination: self.station.Dest1, waitTime: self.station.Wait1),
                    Tram(destination: self.station.Dest2, waitTime: self.station.Wait2),
                    Tram(destination: self.station.Dest3, waitTime: self.station.Wait3)
                ]
                DispatchQueue.main.async {
                    self.title = self.station.StationLocation
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

