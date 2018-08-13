import Foundation
import StationRequest
import CoreSpotlight

struct StationPresentable {
    
    let identifier: Int
    let name: String
    let trams: [TramPresentable]
    let retrievedAt: String
    let messageBoard: String
    
    init () {
        self.identifier = 0
        self.name = "Could not fetch data"
        self.trams = []
        self.retrievedAt = "\(TimeConverter.string(for: Date())), pull down to refresh"
        self.messageBoard = ""
    }
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        var stationTrams: [TramPresentable] = []
        for tram in station.trams {
            stationTrams.append(TramPresentable(tram: tram))
        }
        self.trams = stationTrams
        self.retrievedAt = "\(TimeConverter.string(for: station.retrievedAt)), pull down to refresh"
        self.messageBoard = station.messageBoard != "<no message>" ? station.messageBoard : ""
    }
    
}
