import Foundation

public struct Tram: Codable {
    public let destination: String
    public let waitTime: String
    
    public init(destination: String, waitTime: String) {
        self.destination = destination
        self.waitTime = waitTime
    }
}
