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
        self.retrievedAt = ""
        self.retrievedAt = stringForRetrievalDate(retrievedAt: Date())
    }
    
    init(station: Station) {
        self.name = station.name
        self.firstDestination = station.trams[0].destination
        self.firstWaitTime = "\(station.trams[0].waitTime) mins"
        self.secondDestination = station.trams[1].destination
        self.secondWaitTime = "\(station.trams[1].waitTime) mins"
        self.retrievedAt = ""
        self.retrievedAt = stringForRetrievalDate(retrievedAt: station.retrievedAt)
    }
    
    func stringForRetrievalDate(retrievedAt: Date) -> String {
        let dateString = DateFormatter.localizedString(from: retrievedAt, dateStyle: .none, timeStyle: .short)
        return "Retrieved at \(dateString)"
    }
}
