import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchSessionManager()
    private override init() {
        super.init()
    }
    
    private let session: WCSession = WCSession.default
    
    private var dataSourceChangedDelegates = [DataSourceChangedDelegate]()
    
    func startSession() {
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async() { [weak self] in
            self?.dataSourceChangedDelegates.forEach { $0.dataSourceDidUpdate(dataSource: DataSource(data: applicationContext))}
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        DispatchQueue.main.async() { [weak self] in
            self?.dataSourceChangedDelegates.forEach { $0.dataSourceDidUpdate(dataSource: DataSource(data: userInfo))}
        }
    }

    func updateData() {
        session.sendMessage(["stationIdentifiers":Date()],
        replyHandler: { data in
            self.dataSourceChangedDelegates.forEach { $0.dataSourceDidUpdate(dataSource: DataSource(data: data))}
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    func addDataSourceChangedDelegate<T>(delegate: T) where T: DataSourceChangedDelegate, T: Equatable {
        dataSourceChangedDelegates.append(delegate)
    }
    
    func removeDataSourceChangedDelegate<T>(delegate: T) where T: DataSourceChangedDelegate, T: Equatable {
        for (index, dataSourceDelegate) in dataSourceChangedDelegates.enumerated() {
            if let dataSourceDelegate = dataSourceDelegate as? T, dataSourceDelegate == delegate {
                dataSourceChangedDelegates.remove(at: index)
                break
            }
        }
    }
}

struct DataSource {
    
    let stationIdentifiers: [String]
    
    init(data: [String : Any]) {
        self.stationIdentifiers = Array(data.keys)
    }
}

protocol DataSourceChangedDelegate {
    func dataSourceDidUpdate(dataSource: DataSource)
}
