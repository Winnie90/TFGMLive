import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let stationService = StationServiceAdapter()
    
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var firstDestinationLabel: UILabel!
    @IBOutlet weak var firstDestinationTime: UILabel!
    @IBOutlet weak var secondDestinationLabel: UILabel!
    @IBOutlet weak var secondDestinationTime: UILabel!
    @IBOutlet weak var retrievedAtLabel: UILabel!
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        stationService.getLatestData(completion: { station in
            DispatchQueue.main.async {
                self.stationName.text = station.name
                self.firstDestinationLabel.text = station.firstDestination
                self.firstDestinationTime.text = station.firstWaitTime
                self.secondDestinationLabel.text = station.secondDestination
                self.secondDestinationTime.text = station.secondWaitTime
                self.retrievedAtLabel.text = station.retrievedAt
            }
            completionHandler(NCUpdateResult.newData)
        })
        
    }
}
