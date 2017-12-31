import Foundation
import StationRequest

struct StationPresentable {
    
    let identifier: Int
    let name: String
    let trams: [TramPresentable]
    let retrievedAt: String
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        var stationTrams: [TramPresentable] = []
        for tram in station.trams {
            stationTrams.append(TramPresentable(tram: tram))
        }
        self.trams = stationTrams
        let dateString = DateFormatter.localizedString(from: station.retrievedAt, dateStyle: .none, timeStyle: .short)
        
        self.retrievedAt = "Retrieved at \(dateString), pull down to refresh"
    }
    
}
