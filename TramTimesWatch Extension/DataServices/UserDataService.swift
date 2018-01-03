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
}
