import Foundation

struct StationRequest {
    
    func retrieveStationsApiKey() -> String {
        let path = Bundle(for: AllStationsRequest.self).path(forResource: "apikey", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        let apiKey = try! String(contentsOf: url, encoding: String.Encoding.utf8)
        return apiKey.replacingOccurrences(of:"\n", with:"")
    }
    
    func retrieveStationData(identifier: Int, completion: @escaping (Station)->()) {
        let urlString = "https://api.tfgm.com/odata/Metrolinks(\(identifier))"
        if let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedUrl) {
            var request = URLRequest(url: url)
            request.setValue(retrieveStationsApiKey(), forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    //return error
                }
                if let data = data {
                    do {
                        let station = try JSONDecoder().decode(Station.self, from: data)
                        completion(station)
                    }
                    catch {
                        //return error
                    }
                } else {
                    //return error
                }
            }.resume()
        }
    }
    
}
