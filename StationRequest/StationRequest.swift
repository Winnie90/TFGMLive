import Foundation

struct StationRequest {
    
    func retrieveStationData(identifier: Int, completion: @escaping (Station?, Error?)->()) {
        let urlString = "https://api.tfgm.com/odata/Metrolinks(\(identifier))"
        if let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedUrl) {
            var request = URLRequest(url: url)
            request.setValue(APIRequest.retrieveStationsApiKey(), forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    let parsedError = NSError(domain: "StationRequest", code: RequestError.responseError.rawValue, userInfo: [NSUnderlyingErrorKey: error as Any])
                    completion(nil, parsedError)
                }
                if let data = data {
                    do {
                        let station = try JSONDecoder().decode(Station.self, from: data)
                        completion(station, nil)
                    }
                    catch { 
                        let parsedError = NSError(domain: "StationRequest", code: RequestError.parseError.rawValue, userInfo: [NSUnderlyingErrorKey: error])
                        completion(nil, parsedError)
                    }
                } else {
                    let parsedError = NSError(domain: "StationRequest", code: RequestError.noData.rawValue, userInfo: [NSUnderlyingErrorKey: error as Any])
                    completion(nil, parsedError)
                }
            }.resume()
        }
    }
    
}
