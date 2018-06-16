import UIKit

class MessageBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBoardHeader: UILabel!
    @IBOutlet weak var messageBoardLabel: UILabel!
    
}

extension MessageBoardTableViewCell {
    
    func applyAccessibility() {
        messageBoardHeader.isAccessibilityElement = true
        messageBoardHeader.accessibilityTraits = UIAccessibilityTraits.header
        messageBoardHeader.accessibilityLabel = "message board"
        
        messageBoardLabel.isAccessibilityElement = true
        messageBoardLabel.accessibilityTraits = UIAccessibilityTraits.none
        messageBoardLabel.accessibilityLabel = "message text"
        messageBoardLabel.accessibilityValue = messageBoardLabel.text
    }
    
}

