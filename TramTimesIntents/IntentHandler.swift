//
//  IntentHandler.swift
//  TramTimesIntents
//
//  Created by Chris Winstanley on 23/08/2018.
//  Copyright © 2018 Winstanley. All rights reserved.
//

import Intents
import StationRequest

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is ViewStationIntent else {
            fatalError()
        }
        return ViewStationIntentHandler()
    }
}
