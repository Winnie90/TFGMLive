import Foundation

struct StationService {
    
    func retrieveStationData(identifier: Int, completion: @escaping (Station)->()) {
        let urlString = "https://api.tfgm.com/odata/Metrolinks(\(identifier))"
        if let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedUrl) {
            var request = URLRequest(url: url)
            request.setValue("fb7161bbf7754f188b7f849b69ce6fdd", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
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
