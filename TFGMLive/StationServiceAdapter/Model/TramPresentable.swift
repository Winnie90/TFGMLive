import Foundation
import StationRequest

struct TramPresentable {
    
    let destination: String
    let waitTime: String
    
    init(tram: Tram) {
        self.destination = tram.destination
        self.waitTime = TimeConverter.longString(for: tram.waitTime)
    }
}
