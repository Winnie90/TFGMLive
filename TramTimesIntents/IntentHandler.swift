//
//  IntentHandler.swift
//  TramTimesIntents
//
//  Created by Chris Winstanley on 26/06/2018.
//  Copyright © 2018 Winstanley. All rights reserved.
//

import Intents
import StationRequest

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is ViewStationIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        return ViewStationIntentHandler()
    }
    
}
