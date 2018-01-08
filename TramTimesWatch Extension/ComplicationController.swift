import ClockKit
import WatchKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    var retrievedStation: WatchStationPresentable?
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    func templateFor(complicationFamily: CLKComplicationFamily, tramDestination: String, tramWaitTime: Int) -> CLKComplicationTemplate? {
        var template: CLKComplicationTemplate? = nil
        let minSpecifier = tramWaitTime == 0 ? "" : (tramWaitTime < 2 ? "min" : "mins")
        let combinedWaitTime = "\(tramWaitTime) \(minSpecifier)"
        let waitTimeFraction = Float(tramWaitTime)/20
        switch complicationFamily {
        case .modularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "\(tramWaitTime)")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: minSpecifier)
            template = modularTemplate
        case .modularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Next Tram:")
            modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: tramDestination)
            modularTemplate.body2TextProvider = CLKSimpleTextProvider(text: combinedWaitTime)
            template = modularTemplate
        case .utilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "\(tramWaitTime)")
            modularTemplate.fillFraction = waitTimeFraction
            modularTemplate.ringStyle = CLKComplicationRingStyle.closed
            template = modularTemplate
        case .utilitarianSmallFlat: /* subset of UtilitarianSmall */
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: combinedWaitTime)
            template = modularTemplate
        case .utilitarianLarge: /* maybe not include*/
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: combinedWaitTime)
            template = modularTemplate
        case .circularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: combinedWaitTime)
            modularTemplate.fillFraction = waitTimeFraction
            modularTemplate.ringStyle = CLKComplicationRingStyle.closed
            template = modularTemplate
        case .extraLarge:
            let modularTemplate = CLKComplicationTemplateExtraLargeStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: tramDestination)
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: combinedWaitTime)
            template = modularTemplate
        }
        return template
    }
    
    func retrieveUpdate(completion: @escaping ()->()) {
        let userDataService = UserDataService()
        if Date().timeIntervalSince(userDataService.getComplicationRetrievalDate()) > 60 {
            if let identifier = UserDataService().getStationIdentifiers().first {
                WatchStationServiceAdapter.getLatestDataForStationIdentifier(identifier: identifier, completion: { station in
                    userDataService.setComplicationRetrievalDate()
                    self.retrievedStation = station
                    completion()
                })
            }
        }
        completion()
    }
    
    func convertWaitTime(waitTime: String) -> Int {
        return Int(waitTime) ?? 0
    }
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
//        retrieveUpdate {
//            if let tram = self.retrievedStation?.trams[0],
//                let template = self.templateFor(complicationFamily: complication.family, tramDestination: tram.destination, tramWaitTime: self.convertWaitTime(waitTime: tram.waitTime)){
//                let timeLineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
//                handler(timeLineEntry)
//            } else {
//                handler(nil)
//            }
//        }
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        /*retrieveUpdate {
            if let tram = self.retrievedStation?.trams[0],
                let waitTime = Int(tram.waitTime) {
                var timeLineEntries:[CLKComplicationTimelineEntry] = []
                for i in 0 ..< waitTime {
                    if let template = self.templateFor(complicationFamily: complication.family,
                                                    tramDestination: tram.destination,
                                                    tramWaitTime: self.convertWaitTime(waitTime: tram.waitTime)-i) {
                        let timeLineEntry = CLKComplicationTimelineEntry(date: Date().addingTimeInterval(TimeInterval(i*60)), complicationTemplate: template)
                        timeLineEntries.append(timeLineEntry)
                    }
                }
                handler(timeLineEntries)
            } else {
                handler(nil)
            }
        }*/
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        /*var template: CLKComplicationTemplate? = nil
        switch complication.family {
        case .modularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "24")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "mins")
            template = modularTemplate
        case .modularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Next Tram:")
            modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: "Eccles")
            modularTemplate.body2TextProvider = CLKSimpleTextProvider(text: "6 mins")
            template = modularTemplate
        case .utilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "6 mins")
            modularTemplate.fillFraction = 0.6
            modularTemplate.ringStyle = CLKComplicationRingStyle.open
            template = modularTemplate
        case .utilitarianSmallFlat: /* subset of UtilitarianSmall */
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "6 mins")
            template = modularTemplate
        case .utilitarianLarge: /* maybe not include*/
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "6 mins")
            template = modularTemplate
        case .circularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "6")
            modularTemplate.fillFraction = 0.7
            modularTemplate.ringStyle = CLKComplicationRingStyle.closed
            template = modularTemplate
        case .extraLarge:
            let modularTemplate = CLKComplicationTemplateExtraLargeStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "Eccles:")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "6 mins")
            template = modularTemplate
        }*/
        handler(nil)
    }
}
