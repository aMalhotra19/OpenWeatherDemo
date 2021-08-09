//
//  HomeViewModelTests.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/9/21.
//

import XCTest
import MapKit

@testable import OpenWeatherDemo

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? super.setUpWithError()
        let annotation = MKPointAnnotation()
        viewModel = HomeViewModel(annotations: [annotation])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try? super.tearDownWithError()
    }
    
    func test_NumberOfSection() {
        let sections = viewModel?.numberOfSection()
        XCTAssertEqual(sections, 2)
    }

    func test_NumberOfDefaultRowWithNoAnnotations() {
        let rows = viewModel?.numberOfRow(for: 1)
        XCTAssertEqual(rows, 1)
    }
    
    func test_NumberOfBookmarkRowWithNoAnnotations() {
        let rows = viewModel?.numberOfRow(for: 0)
        XCTAssertEqual(rows, 0)
    }
    
    func test_GetDefaultViewModel() {
        let indexpath = IndexPath(row: 0, section: 0)
        
        let model = viewModel?.getViewModel(for: indexpath)
        XCTAssert(model is DefaultCellViewModel)
    }
    
    func test_GetViewModel() {
        let indexpath = IndexPath(row: 0, section: 1)
        viewModel?.configureBookmarkCellViewModel()
        let model = viewModel?.getViewModel(for: indexpath)
        XCTAssert(model is BookmarkCellViewModel)
    }
}
