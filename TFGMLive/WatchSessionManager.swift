import Foundation

import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {

    static let sharedManager = WatchSessionManager()
    private override init() {
        super.init()
    }
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    private var dataSourceChangedDelegate: DataSourceChangedDelegate?

    private var validSession: WCSession? {
        if let session = session, session.isPaired && session.isWatchAppInstalled {
            return session
        }
        return nil
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
}

extension WatchSessionManager {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if message["stationIdentifiers"] != nil {
            replyHandler(updateStationIdentifiers())
        }
    }
    
    private func updateStationIdentifiers() -> [String: Any] {
        let userStations = self.dataSourceChangedDelegate?.getUserStations()
        let identifiers = userStations?.compactMap{$0.identifier} ?? []
        var applicationContext: [String: Any] = [:]
        for identifier in identifiers {
            applicationContext["\(identifier)"] = ""
        }
        return applicationContext
    }
    
    func updateUserStation() {
        if let session = validSession {
            do {
                try session.updateApplicationContext(self.updateStationIdentifiers())
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

extension WatchSessionManager {
    func addDataSourceChangedDelegate(delegate: DataSourceChangedDelegate) {
        dataSourceChangedDelegate = delegate
    }
}

protocol DataSourceChangedDelegate {
    func getUserStations() -> [StationPresentable]
}
