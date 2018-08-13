import Foundation
import StationRequest
import CoreSpotlight

struct StationRecord {
    
    public let domainIdentifier = "com.winstanley.TramTimesManchester.station"
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

extension StationRecord {
    
    private func attributeSet() -> CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(
            itemContentType: "Station" as String)
        attributeSet.title = name
        attributeSet.contentDescription = "\(direction)\(destinations)"
        return attributeSet
    }
    
    public var searchableItem: CSSearchableItem {
        let item = CSSearchableItem(uniqueIdentifier: "\(identifier)", domainIdentifier: domainIdentifier, attributeSet: attributeSet())
        item.expirationDate = Date.distantFuture
        return item
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
