import Foundation
import StationRequest

struct StationServiceAdapter: DataSourceChangedDelegate {
        
    init() {
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
    }
    
    func getAllStationRecords() -> [StationRecord] {
        var stations: [StationRecord] = []
        for station in StationService.getAllStations() {
            stations.append(StationRecord(station: station))
        }
        return stations
    }
    
    func getUserStations() -> [StationPresentable] {
        var stations: [StationPresentable] = []
        for station in StationService.getUserStations() {
            stations.append(StationPresentable(station: station))
        }
        return stations
    }
    
    func getLatestDataForStation(station: StationPresentable, completion: @escaping (StationPresentable, Error?)->()) {
        return StationService.getLatestDataForStation(identifier: station.identifier, completion: { station, error in
            if let station = station {
                completion(StationPresentable(station: station), nil)
            } else {
                completion(StationPresentable(), error)
            }
        })
    }
    
    func saveUsersStationRecords(stations: [StationRecord]) -> Bool {
        var stationsToSave: [Station] = []
        for station in stations {
            stationsToSave.append(station.toStation())
        }
        if stationsToSave == StationService.getUserStations() {
            return false
        }
        StationService.saveUserStations(stations: stationsToSave)
        WatchSessionManager.sharedManager.updateUserStation()
        return true
    }
    
    func getUsersStationRecords() -> [StationRecord] {
        var stations: [StationRecord] = []
        for station in StationService.getUserStations() {
            stations.append(StationRecord(station: station))
        }
        return stations
    }
}
