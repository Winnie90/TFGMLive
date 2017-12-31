import Foundation

struct UserDefaultsService {
    
    func getUserStations() -> [Station] {
        do {
            if let data = UserDefaults.standard.value(forKey:"stations") as? Data {
                return try PropertyListDecoder().decode(Array<Station>.self, from: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func saveUserStations(stations: [Station]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(stations), forKey:"stations")
    }
}
