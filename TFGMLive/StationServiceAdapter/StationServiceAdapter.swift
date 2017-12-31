import Foundation
import StationRequest

struct StationServiceAdapter {
    
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
    
    func getLatestDataForStations(station: StationPresentable, completion: @escaping (StationPresentable)->()) {
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

struct StationRecord {
    
    let identifier: Int
    let name: String
    let destination: String
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        if let firstDestination = station.trams.first?.destination {
            self.destination = "towards \(firstDestination)"
        } else {
            self.destination = ""
        }
    }
    
    func toStation() -> Station {
        return Station(identifier: identifier, stationUid: "", name: name, trams: [], retrievedAt: Date())
    }
}

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

struct TramPresentable {
    
    let destination: String
    let waitTime: String
    
    init(tram: Tram) {
        self.destination = tram.destination
        self.waitTime = tram.waitTime
    }
}
