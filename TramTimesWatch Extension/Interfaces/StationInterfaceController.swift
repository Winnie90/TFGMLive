import WatchKit
import Foundation
import WatchStationRequest

class StationInterfaceController: WKInterfaceController {
    
    @IBOutlet var stationLabel: WKInterfaceLabel!
    @IBOutlet var retrievedLabel: WKInterfaceLabel!
    @IBOutlet var tramTable: WKInterfaceTable!
    
    var stationIdentifier: String?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        stationIdentifier = context as? String
    }
    
    override func willActivate() {
        super.willActivate()
        performRequest()
    }
    
    func performRequest() {
        if let identifier = stationIdentifier {
            WatchStationServiceAdapter.getLatestDataForStationIdentifier(identifier: identifier, completion: { station, error in
                if let station = station {
                    self.stationLabel.setText(station.name)
                    self.retrievedLabel.setText(station.retrievedAt)
                    if station.trams.count > 0 {
                        self.tramTable.setNumberOfRows(station.trams.count, withRowType: "TramRowController")
                        for (index, tram) in station.trams.enumerated() {
                            let row = self.tramTable.rowController(at: index) as! TramRowController
                            row.destinationLabel.setText(tram.destination)
                            row.waitTimeLabel.setText(tram.waitTime)
                            row.minsLabel.setText(tram.minSpecifier)
                            if tram.minSpecifier.count == 0 {
                                row.waitTimeLabel.setRelativeHeight(1.0, withAdjustment: 0)
                            }
                        }
                    } else {
                        self.tramTable.setNumberOfRows(1, withRowType: "TramRowController")
                        let row = self.tramTable.rowController(at: 0) as! TramRowController
                        row.destinationLabel.setText("No more trams")
                    }
                } else {
                    self.stationLabel.setText("Could not fetch station data, hard press to refresh...")
                    self.retrievedLabel.setText("")
                    self.tramTable.setNumberOfRows(0, withRowType: "TramRowController")
                }
            })
        }
    }
    
    @IBAction func refreshTapped() {
        performRequest()
    }
}
