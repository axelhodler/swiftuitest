import XCTest


class uitestUITests: XCTestCase {

    func testShowsTutorialOnFirstLaunch() throws {
        let app = XCUIApplication()
        app.setSeenTutorial(false)
        app.launch()

        XCTAssertTrue(XCUIApplication().buttons["Continue"].exists)
    }

    func testDoesntShowTutorialIfAlreadySeen() throws {
        let app = XCUIApplication()
        app.setSeenTutorial()
        app.launch()

        XCTAssertFalse(XCUIApplication().buttons["Continue"].exists)
    }
}

extension XCUIApplication {
    func setSeenTutorial(_ seenTutorial: Bool = true) {
        launchArguments += ["-seenTutorial", seenTutorial ? "true" : "false"]
    }
}
