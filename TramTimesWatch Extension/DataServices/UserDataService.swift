import Foundation

struct UserDataService {
    
    func getStationIdentifiers() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "stationIdentifiers") ?? []
    }
    
    func updatedIdentifiers(stationIdentifiers: [String]) -> Bool {
        if stationIdentifiers != getStationIdentifiers() {
            UserDefaults.standard.set(stationIdentifiers, forKey: "stationIdentifiers")
            return true
        } else {
            return false
        }
    }
    
    func getComplicationRetrievalDate() -> Date {
        return UserDefaults.standard.object(forKey: "retrievalDate") as? Date ?? Date.init(timeIntervalSince1970: 0)
    }
    
    func setComplicationRetrievalDate() {
        UserDefaults.standard.set(Date(), forKey: "retrievalDate")
    }
    
}
