//
//  TFGMLiveUITests.swift
//  TFGMLiveUITests
//
//  Created by Christopher Winstanley on 20/01/2018.
//  Copyright © 2018 Winstanley. All rights reserved.
//

import XCTest

class XCUISnapshotTests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testSnapshots() {
        let tablesQuery = app.tables
        let searchField = tablesQuery.children(matching: .searchField).element
        searchField.tap()
        
        searchField.typeText("Pic")
        snapshot("04-AddStation")
        tablesQuery.children(matching: .cell).element(boundBy: 0).tap()
        
        let editStationsNavigationBar = app.navigationBars["Edit Stations"]
        let addButton = editStationsNavigationBar.buttons["Add"]
        
        addButton.tap()
        searchField.typeText("MediaCityUK")
        tablesQuery.children(matching: .cell).element(boundBy: 0).tap()

        addButton.tap()
        searchField.typeText("Vic")
        tablesQuery.children(matching: .cell).element(boundBy: 0).tap()

        snapshot("05-EditStations")
        app.navigationBars["Edit Stations"].buttons["Save"].tap()
        
        snapshot("01-Picadilly")
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeLeft()
        
        snapshot("02-MediaCityUK")
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeLeft()

        snapshot("03-Victoria")
        
    }
    
}
