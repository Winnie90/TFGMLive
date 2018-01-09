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
