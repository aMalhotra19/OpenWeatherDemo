//
//  HomeViewControllerTests.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/10/21.
//

import XCTest
import MapKit

@testable import OpenWeatherDemo

class HomeViewControllerTests: XCTestCase {
    var controller: HomeViewController?
    var navigationController: UINavigationController?
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        let annotation = MKPointAnnotation()
        let viewModel = HomeViewModel(annotations: [annotation])
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        controller?.viewModel = viewModel
        navigationController = UINavigationController(rootViewController: controller!)
    }

    override func tearDownWithError() throws {
        controller = nil        
        navigationController = nil
        try? super.tearDownWithError()
    }

    func test_ViewLoad() {
        controller?.loadViewIfNeeded()
        XCTAssertEqual("Bookmarks", controller?.title)
    }

    func test_RouteToLocationVC() {
        controller?.routeToLocationVC()
        XCTAssertTrue(controller?.activityView.isAnimating == true)
    }

    func test_HideIndicator() {
        XCTAssertTrue(controller?.activityView.isAnimating == false)
    }
    
    func test_ViewDidDisappear() {
        XCTAssertTrue(controller?.activityView.isAnimating == false)
    }
    
    func test_DefaultCell() {
        let cell = cellAt(section: 0) as? DefaultCell
        XCTAssertEqual(cell?.reuseIdentifier, "DefaultCell")
    }
    
    func test_BookmarkCell() {
        controller?.viewModel.configureBookmarkCellViewModel()
        let cell = cellAt(section: 1) as? BookmarkCell
        XCTAssertEqual(cell?.reuseIdentifier, "BookmarkCell")
    }
    
    func cellAt(section: Int) -> UITableViewCell {
        controller?.loadViewIfNeeded()
        guard let controller = controller else {return UITableViewCell()}
        return controller.tableView(controller.bookmarkTableView, cellForRowAt: IndexPath.init(row: 0, section: section))
    }
}
