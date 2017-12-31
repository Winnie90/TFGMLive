import Foundation

struct Response: Decodable {
    let value: [Station]
}

class AllStationsRequest {
    
    func retrieveStationsData() -> [Station] {
        var stations: [Station] = []
        let path = Bundle(for: AllStationsRequest.self).path(forResource: "stations", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url, options: .uncached)
        let parsedStationData = try? JSONDecoder().decode(Response.self, from: data)
        stations = (parsedStationData?.value)!
        stations = stations.filterDuplicates { (station1, station2) -> Bool in
            return station1.stationUid == station2.stationUid
            }.sorted(by: { (station1, station2) -> Bool in
                station1.name < station2.name
            })
        return stations
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
