import Foundation

struct UserDefaultsService {
    
    let userDefaults = UserDefaults.init(suiteName: "group.com.winstanley.TramTimesManchester.SharingDefaults")!
    
    func getUserStations() -> [Station] {
        do {
            if let data = userDefaults.value(forKey:"stations") as? Data {
                return try PropertyListDecoder().decode(Array<Station>.self, from: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func saveUserStations(stations: [Station]) {
        userDefaults.set(try? PropertyListEncoder().encode(stations), forKey:"stations")
    }
}
