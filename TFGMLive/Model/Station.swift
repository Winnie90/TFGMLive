import Foundation

struct Station: Codable {
    let identifier: Int
    let stationUid: String
    let name: String
    let trams: [Tram]
}

extension Station {
    enum StationKeys: String, CodingKey {
        case stationUid = "AtcoCode"
        case identifier = "Id"
        case name = "StationLocation"
        case firstTramDestination = "Dest0"
        case firstTramWaitingTime = "Wait0"
        case secondTramDestination = "Dest1"
        case secondTramWaitingTime = "Wait1"
        case thirdTramDestination = "Dest2"
        case thirdTramWaitingTime = "Wait2"
        case fourthTramDestination = "Dest3"
        case fourthTramWaitingTime = "Wait3"
        case savedStationUid = "stationUid"
        case savedIdentifier = "identifier"
        case savedName = "name"
        case savedTrams = "trams"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StationKeys.self)
        
        do {
            let stationUid: String = try container.decode(String.self, forKey: .stationUid)
            let identifier: Int = try container.decode(Int.self, forKey: .identifier)
            let name: String = try container.decode(String.self, forKey: .name)
            let firstTramDestination: String = try container.decode(String.self, forKey: .firstTramDestination)
            let firstTramWaitingTime: String = try container.decode(String.self, forKey: .firstTramWaitingTime)
            let secondTramDestination: String = try container.decode(String.self, forKey: .secondTramDestination)
            let secondTramWaitingTime: String = try container.decode(String.self, forKey: .secondTramWaitingTime)
            let thirdTramDestination: String = try container.decode(String.self, forKey: .thirdTramDestination)
            let thirdTramWaitingTime: String = try container.decode(String.self, forKey: .thirdTramWaitingTime)
            let fourthTramDestination: String = try container.decode(String.self, forKey: .fourthTramDestination)
            let fourthTramWaitingTime: String = try container.decode(String.self, forKey: .fourthTramWaitingTime)
            self.init(identifier: identifier,
                      stationUid: stationUid,
                      name: name,
                      trams:[
                        Tram(destination: firstTramDestination, waitTime: firstTramWaitingTime),
                        Tram(destination: secondTramDestination, waitTime: secondTramWaitingTime),
                        Tram(destination: thirdTramDestination, waitTime: thirdTramWaitingTime),
                        Tram(destination: fourthTramDestination, waitTime: fourthTramWaitingTime)
                ]
            )
        } catch {
            let stationUid: String = try container.decode(String.self, forKey: .savedStationUid)
            let identifier: Int = try container.decode(Int.self, forKey: .savedIdentifier)
            let name: String = try container.decode(String.self, forKey: .savedName)
            let trams: [Tram] = try container.decode(Array<Tram>.self, forKey: .savedTrams)
            self.init(identifier: identifier,
                      stationUid: stationUid,
                      name: name,
                      trams:trams
            )
        }
        
        
    }
}