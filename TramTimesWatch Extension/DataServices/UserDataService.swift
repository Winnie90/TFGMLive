import Foundation

struct UserDataService {
    
    func getStationIdentifiers() -> [Int] {
        return [1, 2, 3]
        //return UserDefaults.standard.stringArray(forKey: "stationIdentifiers") ?? []
    }
}
