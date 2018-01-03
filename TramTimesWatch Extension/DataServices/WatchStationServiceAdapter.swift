import WatchStationRequest

struct StationServiceAdapter {
    
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
                let timeRepresentation = string(for: tram.waitTime)
                tempTrams.append(WatchTramPresentable(destination: tram.destination, waitTime: timeRepresentation.waitTime, minSpecifier: timeRepresentation.minSpecifier))
            }
        }
        self.trams = tempTrams
        self.retrievedAt = stringForRetrievalDate(retrievedAt: station.retrievedAt)
    }
    
    func stringForRetrievalDate(retrievedAt: Date) -> String {
        let dateString = DateFormatter.localizedString(from: retrievedAt, dateStyle: .none, timeStyle: .short)
        return "Updated at \(dateString)"
    }
    
    func string(for waitTime: String) -> (waitTime: String, minSpecifier: String) {
        return waitTime == "0" ? ("Due", "") :
        (Int(waitTime)! < 2 ? (waitTime, "min") : (waitTime, "mins"))
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
