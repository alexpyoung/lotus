//
//  LotusUITests.swift
//  LotusUITests
//
//  Created by Alex Young on 3/7/20.
//  Copyright © 2020 Alex Young. All rights reserved.
//

import XCTest

class LotusUITests: XCTestCase {

    override func setUp() {
      self.continueAfterFailure = false
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
