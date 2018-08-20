import Foundation
import StationRequest
import Intents

struct StationPresentable {
    
    let identifier: Int
    let name: String
    let trams: [TramPresentable]
    let retrievedAt: String
    let messageBoard: String
    
    init () {
        self.identifier = 0
        self.name = "Could not fetch data"
        self.trams = []
        self.retrievedAt = "\(TimeConverter.string(for: Date())), pull down to refresh"
        self.messageBoard = ""
    }
    
    init(station: Station) {
        self.identifier = station.identifier
        self.name = station.name
        var stationTrams: [TramPresentable] = []
        for tram in station.trams {
            stationTrams.append(TramPresentable(tram: tram))
        }
        self.trams = stationTrams
        self.retrievedAt = "\(TimeConverter.string(for: station.retrievedAt)), pull down to refresh"
        self.messageBoard = station.messageBoard != "<no message>" ? station.messageBoard : ""
    }
    
    var userActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: "com.winstanley.TramTimesManchester.viewStation")
        activity.isEligibleForSearch = true
        activity.title = name
        activity.userInfo = ["identifier": identifier]
        if #available(iOS 12.0, *) {
            activity.isEligibleForPrediction = true
            activity.suggestedInvocationPhrase = "Tram Time"
        }
        
        return activity
    }
    
}
