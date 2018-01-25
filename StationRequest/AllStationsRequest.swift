import Foundation

struct Response: Decodable {
    let value: [Station]
}

class AllStationsRequest {
    
    func retrieveStationsData(completion: @escaping ([Station], Error?)->()) {
        var stations: [Station] = []
        let urlString = "https://api.tfgm.com/odata/Metrolinks"
        if let escapedUrl = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedUrl) {
            var request = URLRequest(url: url)
            request.setValue(APIRequest.retrieveStationsApiKey(), forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    let parsedError = NSError(domain: "AllStationRequest", code: RequestError.responseError.rawValue, userInfo: [NSUnderlyingErrorKey: error as Any])
                    completion([], parsedError)
                }
                if let data = data {
                    do {
                        let parsedStationData = try JSONDecoder().decode(Response.self, from: data)
                        stations = parsedStationData.value
                        stations = stations.filterDuplicates { (station1, station2) -> Bool in
                            return station1.stationUid == station2.stationUid
                            }.sorted(by: { (station1, station2) -> Bool in
                                station1.name < station2.name
                            })
                        completion(stations, nil)
                    } catch {
                        let parsedError = NSError(domain: "StationRequest", code: RequestError.parseError.rawValue, userInfo: [NSUnderlyingErrorKey: error])
                        completion([], parsedError)
                    }
                } else {
                    let parsedError = NSError(domain: "StationRequest", code: RequestError.noData.rawValue, userInfo: [NSUnderlyingErrorKey: error as Any])
                    completion([], parsedError)
                }
                }.resume()
        }
    }
}

extension Array {
    
    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {
        var results = [Element]()
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}
