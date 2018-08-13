//
//  StationIndexer.swift
//  TFGMLive
//
//  Created by Chris Winstanley on 13/08/2018.
//  Copyright © 2018 Winstanley. All rights reserved.
//

import CoreSpotlight

struct StationIndexer {
    static func index(stations: [StationRecord]) {
        CSSearchableIndex.default().indexSearchableItems(stations.map{$0.searchableItem}) { error in
                if let error = error {
                    print("Indexing error: \(error.localizedDescription)")
                } else {
                    print("Search item successfully indexed!")
                }
        }
    }
}
