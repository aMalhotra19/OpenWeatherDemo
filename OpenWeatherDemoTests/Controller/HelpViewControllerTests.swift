//
//  HelpViewControllerTests.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/10/21.
//

import XCTest
import WebKit

@testable import OpenWeatherDemo

class HelpViewControllerTests: XCTestCase {
    var controller: HelpViewController?
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController
    }

    override func tearDownWithError() throws {
        controller = nil
        try? super.tearDownWithError()
    }

    func test_ViewLoad() {
        //controller?.webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        controller?.loadViewIfNeeded()
        XCTAssertFalse(controller?.webView.isLoading == false)
        XCTAssertEqual("Help", controller?.title)
    }    
}
