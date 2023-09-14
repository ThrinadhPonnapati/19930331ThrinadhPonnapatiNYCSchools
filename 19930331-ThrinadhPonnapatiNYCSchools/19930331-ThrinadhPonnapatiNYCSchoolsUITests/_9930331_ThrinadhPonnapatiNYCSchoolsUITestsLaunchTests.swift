//
//  _9930331_ThrinadhPonnapatiNYCSchoolsUITestsLaunchTests.swift
//  19930331-ThrinadhPonnapatiNYCSchoolsUITests
//
//  Created by Thrinadh Ponnapati  on 9/13/23.
//

import XCTest

final class _9930331_ThrinadhPonnapatiNYCSchoolsUITestsLaunchTests: XCTestCase {

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
