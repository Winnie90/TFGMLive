import Foundation

enum RequestError: Int {
    case noStation = 0
    case responseError = 1
    case noData = 2
    case parseError = 3
}

public struct StationService {
    
    public static func getAllStations(completion: @escaping ([Station]?, Error?)->()) {
        return AllStationsRequest().retrieveStationsData(completion: completion)
    }
    
    public static func getUserStations() -> [Station] {
        return UserDefaultsService().getUserStations()
    }
    
    public static func addStation(identifier: Int, completion: @escaping ()->()) {
        AllStationsRequest().retrieveStationsData { (allStations, error) in
            if let _ = error {
                completion()
            } else {
                var stations = getUserStations()
                guard let stationToAdd = allStations.first(where: {
                    $0.identifier == identifier
                }) else {
                    completion()
                    return
                }
                stations.append(stationToAdd)
                saveUserStations(stations: stations)
                completion()
            }
        }
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
