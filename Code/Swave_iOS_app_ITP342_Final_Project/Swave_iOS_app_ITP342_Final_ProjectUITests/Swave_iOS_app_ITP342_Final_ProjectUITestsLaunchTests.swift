//
//  Swave_iOS_app_ITP342_Final_ProjectUITestsLaunchTests.swift
//  Swave_iOS_app_ITP342_Final_ProjectUITests
//
//  Created by Todd Gavin on 11/24/22.
//

import XCTest

final class Swave_iOS_app_ITP342_Final_ProjectUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
