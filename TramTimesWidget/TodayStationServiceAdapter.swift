import Foundation
import StationRequest

struct StationServiceAdapter {
    
    func getLatestData(completion: @escaping (TodayStationPresentable)->()) {
        StationService.getLatestDataForUserFavouriteStation(completion: { station in
            if let station = station {
                completion(TodayStationPresentable(station: station))
            } else {
                completion(TodayStationPresentable())
            }
        })
    }
    
}

struct TodayStationPresentable {
    let name: String
    let firstDestination: String
    let firstWaitTime: String
    let secondDestination: String
    let secondWaitTime: String
    var retrievedAt: String
    
    init() {
        self.name = "Could not retrieve data"
        self.firstDestination = ""
        self.firstWaitTime = ""
        self.secondDestination = ""
        self.secondWaitTime = ""
        self.retrievedAt = TimeConverter.string(for: Date())
    }
    
    init(station: Station) {
        self.name = station.name
        self.firstDestination = station.trams[0].destination
        self.firstWaitTime = TimeConverter.longString(for: station.trams[0].waitTime)
        self.secondDestination = station.trams[1].destination
        self.secondWaitTime = TimeConverter.longString(for: station.trams[1].waitTime)
        self.retrievedAt = TimeConverter.string(for: station.retrievedAt)
    }

}
