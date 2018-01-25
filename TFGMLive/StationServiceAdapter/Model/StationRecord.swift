import Foundation
import StationRequest

struct StationRecord {
    
    let identifier: Int
    let name: String
    let direction: String
    let destinations: String
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        self.direction = station.direction
        self.destinations = station.destinations
    }
    
    func toStation() -> Station {
        return Station(identifier: identifier,
                       stationUid: "",
                       name: name,
                       trams: [],
                       retrievedAt: Date(),
                       messageBoard: "",
                       direction: direction,
                       destinations: destinations)
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
