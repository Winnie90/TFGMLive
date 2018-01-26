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
        stationNameLabel.accessibilityTraits = UIAccessibilityTraitHeader
        stationNameLabel.accessibilityLabel = "station name"
        stationNameLabel.accessibilityValue = stationNameLabel.text

        destinationLabel.isAccessibilityElement = true
        destinationLabel.accessibilityTraits = UIAccessibilityTraitNone
        destinationLabel.accessibilityLabel = "destination name"
        destinationLabel.accessibilityValue = destinationLabel.text
        
        timeLabel.isAccessibilityElement = true
        timeLabel.accessibilityTraits = UIAccessibilityTraitNone
        timeLabel.accessibilityValue = timeLabel.text
        
        retrievedAtLabel.isAccessibilityElement = true
        retrievedAtLabel.accessibilityTraits = UIAccessibilityTraitNone
        retrievedAtLabel.accessibilityValue = retrievedAtLabel.text
        
        accessibilityElements = [stationNameLabel, destinationLabel, timeLabel, retrievedAtLabel]
    }
    
}
