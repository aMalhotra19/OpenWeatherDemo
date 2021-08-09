//
//  WeatherViewControllerTest.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/10/21.
//

import XCTest
import WebKit

@testable import OpenWeatherDemo

class WeatherViewControllerTest: XCTestCase {
    var controller: WeatherViewController?
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        controller = WeatherViewController()
    }
    
    override func tearDownWithError() throws {
        controller = nil
        try? super.tearDownWithError()
    }
    
    func test_ViewLoad() {
        controller?.loadViewIfNeeded()
        XCTAssertEqual("Weather", controller?.title)
    }
}
