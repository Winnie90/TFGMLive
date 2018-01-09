import Foundation

struct StationRequest {
    
    var error: (Error?) -> ()

    func performRequest(identifier: String) -> Station {
        let urlString = "https://api.tfgm.com/odata/Metrolinks(\(identifier))"
        guard let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedUrl) else {
                return Station(identifier: , stationUid: <#T##String#>, name: <#T##String#>, trams: [])
        }
        
        var request = URLRequest(url: url)
        request.setValue("fb7161bbf7754f188b7f849b69ce6fdd", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.error(error)
            }
            if let data = data {
                return try? JSONDecoder().decode(Station.self, from: data)
                
            } else {
                self.error(nil)
            }
        }.resume()
    }

}
