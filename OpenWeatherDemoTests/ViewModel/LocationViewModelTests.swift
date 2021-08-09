//
//  LocationViewModelTests.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/9/21.
//

import XCTest
import MapKit
@testable import OpenWeatherDemo

class LocationViewModelTests: XCTestCase {
    var viewModel: LocationViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.        
        try? super.setUpWithError()
        let annotation = MKPointAnnotation()
        viewModel = LocationViewModel(annotations: [annotation])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try? super.tearDownWithError()
    }

    func test_UpdateAnnotation() {
        viewModel.updateAnnotation()
        XCTAssertEqual(BookmarkManager.shared.annotations.count, 1)
    }
}
