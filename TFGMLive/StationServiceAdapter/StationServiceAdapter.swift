import Foundation
import StationRequest

struct StationServiceAdapter: DataSourceChangedDelegate {
    
    init() {
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
    }
    
    func watchUpdateRequested() {
        if let station = StationService.getUserStations().first {
            getLatestDataForStation(station: StationPresentable(station: station), completion: { stationData in
                var appContext = ["name": stationData.name]
                var i = 0
                for tram in stationData.trams {
                    appContext["\(i)TramDestination"] = tram.destination
                    appContext["\(i)TramWaitTime"] = tram.waitTime
                    i += 1
                }
                WatchSessionManager.sharedManager.transferUserInfo(applicationContext: appContext as [String : AnyObject])
            })
        }
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
    
    func getLatestDataForStation(station: StationPresentable, completion: @escaping (StationPresentable)->()) {
        return StationService.getLatestDataForStation(identifier: station.identifier, completion: { station in
            completion(StationPresentable(station: station))
        })
    }
    
    func saveUsersStationRecords(stations: [StationRecord]) {
        var stationsToSave: [Station] = []
        for station in stations {
            stationsToSave.append(station.toStation())
        }
        StationService.saveUserStations(stations: stationsToSave)
    }
    
    func getUsersStationRecords() -> [StationRecord] {
        var stations: [StationRecord] = []
        for station in StationService.getUserStations() {
            stations.append(StationRecord(station: station))
        }
        return stations
    }
}
