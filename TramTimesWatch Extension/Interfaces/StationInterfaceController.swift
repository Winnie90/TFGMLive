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
        if let identifier = stationIdentifier {
            WatchStationServiceAdapter.getLatestDataForStationIdentifier(identifier: identifier, completion: { station in
                self.stationLabel.setText(station.name)
                self.retrievedLabel.setText(station.retrievedAt)
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
            })
        }
        
    }
}
