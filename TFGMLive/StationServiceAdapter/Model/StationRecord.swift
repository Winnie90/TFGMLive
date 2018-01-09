import Foundation
import StationRequest

struct StationRecord {
    
    let identifier: Int
    let name: String
    let destination: String
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        if let firstDestination = station.trams.first?.destination {
            self.destination = firstDestination
        } else {
            self.destination = ""
        }
    }
    
    func toStation() -> Station {
        return Station(identifier: identifier, stationUid: "",
                       name: name,
                       trams: [Tram(destination: destination, waitTime:"0")],
                       retrievedAt: Date())
    }
}
