//
//  ViewStationIntentHandler.swift
//  StationRequest
//
//  Created by Chris Winstanley on 19/06/2018.
//  Copyright © 2018 Winstanley. All rights reserved.
//

import Foundation

public class ViewStationIntentHandler: NSObject, ViewStationIntentHandling {
    
    @available(iOSApplicationExtension 12.0, *)
    public func handle(intent: ViewStationIntent, completion: @escaping (ViewStationIntentResponse) -> Void) {
        guard let station = intent.station,
            let stationIdentifier = station.identifier else {
            let response = ViewStationIntentResponse(code: .failure, userActivity: nil)
            completion(response)
            return
        }
        let identifier = Int(stationIdentifier) ?? 0
        StationService.getLatestDataForStation(identifier: identifier) { (station, error) in
            if let _ = error {
                let response = ViewStationIntentResponse(code: .failure, userActivity: nil)
                completion(response)
            }
            if let station = station,
                let nextTram = station.trams.first {
                let response = ViewStationIntentResponse.information(destination: nextTram.destination, waitTime: nextTram.waitTime)
                completion(response)
            } else {
                let response = ViewStationIntentResponse(code: .failure, userActivity: nil)
                completion(response)
            }
            return
        }
    }
}
