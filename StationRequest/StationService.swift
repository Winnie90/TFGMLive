import Foundation

enum RequestError: Int {
    case noStation = 0
    case responseError = 1
    case noData = 2
    case parseError = 3
}

public struct StationService {
    
    public static func getAllStations() -> [Station] {
        return AllStationsRequest().retrieveStationsData()
    }
    
    public static func getUserStations() -> [Station] {
        return UserDefaultsService().getUserStations()
    }
    
    public static func saveUserStations(stations: [Station]) {
        return UserDefaultsService().saveUserStations(stations: stations)
    }
    
    public static func getLatestDataForStation(identifier:Int, completion: @escaping (Station?, Error?)->()) {
        return StationRequest().retrieveStationData(identifier: identifier, completion: completion)
    }
    
    public static func getLatestDataForUserFavouriteStation(completion: @escaping (Station?, Error?)->()) {
        if let station = UserDefaultsService().getUserStations().first {
            return StationRequest().retrieveStationData(identifier: station.identifier, completion: completion)
        } else {
            let error = NSError(domain: "StationRequest", code: RequestError.noStation.rawValue, userInfo: nil)
            completion(nil, error)
        }
    }

}
