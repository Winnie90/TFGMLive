import Foundation
import Intents

public struct Station: Codable {
    public let identifier: Int
    public let stationUid: String
    public let name: String
    public let trams: [Tram]
    public let retrievedAt: Date
    public let messageBoard: String
    public let direction: String
    public let destinations: String
    
    public init(identifier: Int,
                stationUid: String,
                name: String,
                trams: [Tram],
                retrievedAt: Date,
                messageBoard: String,
                direction: String,
                destinations: String) {
        self.identifier = identifier
        self.stationUid = stationUid
        self.name = name
        self.trams = trams
        self.retrievedAt = retrievedAt
        self.messageBoard = messageBoard
        self.direction = direction
        self.destinations = destinations
    }
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
        case savedRetrievedAt = "retrievedAt"
        case messageBoard = "MessageBoard"
        case savedMessageBoard = "messageBoard"
        case direction = "Direction"
        case savedDirection = "direction"
        case savedDestinations = "destinations"
    }
    
    public init(from decoder: Decoder) throws {
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
            let messageBoard: String = try container.decode(String.self, forKey: .messageBoard)
            var direction: String = try container.decode(String.self, forKey: .direction)
            
            var trams: [Tram] = []
            if firstTramDestination != "" {
                trams.append(Tram(destination: firstTramDestination, waitTime: firstTramWaitingTime))
            }
            if secondTramDestination != "" {
                trams.append(Tram(destination: secondTramDestination, waitTime: secondTramWaitingTime))
            }
            if thirdTramDestination != "" {
                trams.append(Tram(destination: thirdTramDestination, waitTime: thirdTramWaitingTime))
            }
            if fourthTramDestination != "" {
                trams.append(Tram(destination: fourthTramDestination, waitTime: fourthTramWaitingTime))
            }
            
            if direction == "Incoming" {
                direction = "towards Manchester"
            } else {
                direction = "leaving Manchester"
            }
            
            var destinations = ""
            if trams.count > 0 {
                destinations = " to "
            } else {
                destinations = " 2nd platform"
            }
            
            let destinationNames = trams.map{$0.destination}.filterDuplicates{ (station1, station2) -> Bool in
                return station1 == station2
            }
            
            for (i, destination) in destinationNames.enumerated() {
                if destination.lowercased() != "see tram front" {
                    destinations.append(destination)
                }
                if i+1 < destinationNames.count {
                    destinations.append(", ")
                }
            }
            
            self.init(identifier: identifier,
                    stationUid: stationUid,
                    name: name,
                    trams:trams,
                    retrievedAt: Date(),
                    messageBoard: messageBoard,
                    direction: direction,
                    destinations: destinations
            )
        } catch {
            let stationUid: String = try container.decode(String.self, forKey: .savedStationUid)
            let identifier: Int = try container.decode(Int.self, forKey: .savedIdentifier)
            let name: String = try container.decode(String.self, forKey: .savedName)
            let trams: [Tram] = try container.decode(Array<Tram>.self, forKey: .savedTrams)
            let retrievedAt: Date = try container.decode(Date.self, forKey: .savedRetrievedAt)
            let messageBoard: String = try container.decode(String.self, forKey: .savedMessageBoard)
            
            var direction = ""
            if let decodedDirection = try container.decodeIfPresent(String.self, forKey: .savedDirection) {
                direction = decodedDirection
            } else {
                direction = ""
            }
            
            var destinations = ""
            if let decodedDestinations = try container.decodeIfPresent(String.self, forKey: .savedDestinations) {
                destinations = decodedDestinations
            } else {
                destinations = ""
            }
            self.init(identifier: identifier,
                      stationUid: stationUid,
                      name: name,
                      trams: trams,
                      retrievedAt: retrievedAt,
                      messageBoard: messageBoard,
                      direction: direction,
                      destinations: destinations
            )
        }
    }
    
    
}

extension Station: Equatable {
    public static func == (lhs: Station, rhs: Station) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Station {
    @available(watchOSApplicationExtension 5.0, *)
    @available(iOSApplicationExtension 12.0, *)
    public var intent: ViewStationIntent {
        let viewStationIntent = ViewStationIntent()
        viewStationIntent.station = INObject(identifier: String(identifier), display: name)
        viewStationIntent.suggestedInvocationPhrase = "View latest tram times for \(name)"
        return viewStationIntent
    }
}
