import UIKit

class LargeTramTableViewCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retrievedAtLabel: UILabel!
}

extension LargeTramTableViewCell {
    
    func applyAccessibility(_ station: StationPresentable?) {
        
        stationNameLabel.isAccessibilityElement = true
        stationNameLabel.accessibilityTraits = UIAccessibilityTraits.header
        stationNameLabel.accessibilityLabel = "station name"
        stationNameLabel.accessibilityValue = stationNameLabel.text

        destinationLabel.isAccessibilityElement = true
        destinationLabel.accessibilityTraits = UIAccessibilityTraits.none
        destinationLabel.accessibilityLabel = "destination name"
        destinationLabel.accessibilityValue = destinationLabel.text
        
        timeLabel.isAccessibilityElement = true
        timeLabel.accessibilityTraits = UIAccessibilityTraits.none
        timeLabel.accessibilityValue = timeLabel.text
        
        retrievedAtLabel.isAccessibilityElement = true
        retrievedAtLabel.accessibilityTraits = UIAccessibilityTraits.none
        retrievedAtLabel.accessibilityValue = retrievedAtLabel.text
        
        accessibilityElements = [stationNameLabel, destinationLabel, timeLabel, retrievedAtLabel]
    }
    
}
