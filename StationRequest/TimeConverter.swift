import Foundation

public struct TimeConverter {
    
    public static func string(for retrievalDate: Date) -> String {
        let dateString = DateFormatter.localizedString(from: retrievalDate, dateStyle: .none, timeStyle: .short)
        return "Updated at \(dateString)"
    }
    
    public static func timeComponents(for waitTime: String) -> (waitTime: String, minSpecifier: String) {
        return waitTime == "0" ? ("Due", "") :
            (Int(waitTime)! < 2 ? (waitTime, "min") : (waitTime, "mins"))
    }
    
    public static func longString(for waitTime: String) -> String {
        guard let waitTime = Int(waitTime) else { return "Due" }
        
        if waitTime < 2 {
            return "Due in 1 min at \(DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short))"
        } else {
            return "Due in \(waitTime) mins at \(DateFormatter.localizedString(from: Date().addingTimeInterval(TimeInterval(waitTime*60)), dateStyle: .none, timeStyle: .short))"
        }
    }

}
