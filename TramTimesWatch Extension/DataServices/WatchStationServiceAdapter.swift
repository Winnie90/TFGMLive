import WatchStationRequest

struct WatchStationServiceAdapter {
    
    static func getLatestDataForStationIdentifier(identifier: String, completion: @escaping (WatchStationPresentable)->()) {
        if let identifier = Int(identifier) {
            StationService.getLatestDataForStation(identifier: identifier, completion: { station in
                completion(WatchStationPresentable(station: station))
            })
        }
    }
    
}

struct WatchStationPresentable {
    let name: String
    var trams: [WatchTramPresentable]
    var retrievedAt: String
    
    init(station: Station) {
        self.name = station.name
        self.trams = []
        self.retrievedAt = ""
        var tempTrams:[WatchTramPresentable] = []
        for tram in station.trams {
            if  validTram(tram) {
                let timeRepresentation = TimeConverter.timeComponents(for: tram.waitTime)
                tempTrams.append(WatchTramPresentable(destination: tram.destination, waitTime: timeRepresentation.waitTime, minSpecifier: timeRepresentation.minSpecifier))
            }
        }
        self.trams = tempTrams
        self.retrievedAt = TimeConverter.string(for: station.retrievedAt)
    }
    
    func validTram(_ tram: Tram) -> Bool {
        return tram.destination != "" && tram.waitTime != ""
    }
}

struct WatchTramPresentable {
    let destination: String
    let waitTime: String
    let minSpecifier: String
}
