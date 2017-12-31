import Foundation

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
    
    public static func getLatestDataForStation(identifier:Int, completion: @escaping (Station)->()) {
        return StationRequest().retrieveStationData(identifier: identifier, completion: completion)
    }
    
    public static func getLatestDataForUserFavouriteStation(completion: @escaping (Station?)->()) {
        if let station = UserDefaultsService().getUserStations().first {
            return StationRequest().retrieveStationData(identifier: station.identifier, completion: completion)
        } else {
            completion(nil)
        }
    }

}
