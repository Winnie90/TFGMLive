import Foundation
import StationRequest

struct StationPresentable {
    
    let identifier: Int
    let name: String
    let trams: [TramPresentable]
    let retrievedAt: String
    let messageBoard: String
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        var stationTrams: [TramPresentable] = []
        for tram in station.trams {
            stationTrams.append(TramPresentable(tram: tram))
        }
        self.trams = stationTrams
        self.retrievedAt = "\(TimeConverter.string(for: station.retrievedAt)), pull down to refresh"
        self.messageBoard = station.messageBoard
    }
    
}
