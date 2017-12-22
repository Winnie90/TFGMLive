import UIKit

struct Station: Codable {
    let identifier: Int
    let stationUid: String
    let name: String
    let trams: [Tram]
}

extension Station {
    enum StationKeys: String, CodingKey {
        case stationUid = "AtcoCode"
        case identifier = "Id"
        case name = "StationLocation"
        case firstTramDestination = "Dest0"
        case firstTramWaitingTime = "Wait0"
        case secondTramDestination = "Dest1"
        case secondTramWaitingTime = "Wait1"
        case thirdTramDestination = "Dest2"
        case thirdTramWaitingTime = "Wait2"
        case fourthTramDestination = "Dest3"
        case fourthTramWaitingTime = "Wait3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StationKeys.self)
        
        let stationUid: String = try container.decode(String.self, forKey: .stationUid)
        let identifier: Int = try container.decode(Int.self, forKey: .identifier)
        let name: String = try container.decode(String.self, forKey: .name)
        let firstTramDestination: String = try container.decode(String.self, forKey: .firstTramDestination)
        let firstTramWaitingTime: String = try container.decode(String.self, forKey: .firstTramWaitingTime)
        let secondTramDestination: String = try container.decode(String.self, forKey: .secondTramDestination)
        let secondTramWaitingTime: String = try container.decode(String.self, forKey: .secondTramWaitingTime)
        let thirdTramDestination: String = try container.decode(String.self, forKey: .thirdTramDestination)
        let thirdTramWaitingTime: String = try container.decode(String.self, forKey: .thirdTramWaitingTime)
        let fourthTramDestination: String = try container.decode(String.self, forKey: .fourthTramDestination)
        let fourthTramWaitingTime: String = try container.decode(String.self, forKey: .fourthTramWaitingTime)
        
        self.init(identifier: identifier,
                  stationUid: stationUid,
                  name: name,
                  trams:[
                    Tram(destination: firstTramDestination, waitTime: firstTramWaitingTime),
                    Tram(destination: secondTramDestination, waitTime: secondTramWaitingTime),
                    Tram(destination: thirdTramDestination, waitTime: thirdTramWaitingTime),
                    Tram(destination: fourthTramDestination, waitTime: fourthTramWaitingTime)
            ]
        )
    }
}

struct Tram: Codable {
    let destination: String
    let waitTime: String
}

class TramsTableViewController: UITableViewController {
    
    var trams: [Tram] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performRequest()
        
        refreshControl?.addTarget(self, action: #selector(performRequest), for: UIControlEvents.valueChanged)
    }
    
    @objc func performRequest() {
        var requestId = 1
        if let stations = UserDefaults.standard.array(forKey: "stations") as? [Station],
            let requestIdentifier = stations.first?.identifier{
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

