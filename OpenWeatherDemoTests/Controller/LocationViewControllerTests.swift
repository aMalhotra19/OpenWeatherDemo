//
//  LocationViewControllerTests.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/10/21.
//

import XCTest
import MapKit
@testable import OpenWeatherDemo

class LocationViewControllerTests: XCTestCase {
    var controller: LocationViewController?
    var navigationController: UINavigationController?
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        navigationController = getController()
    }

    override func tearDownWithError() throws {
        controller = nil
        try? super.tearDownWithError()
    }

    func test_ViewLoad() {
        controller?.loadViewIfNeeded()
        XCTAssertEqual("Location", controller?.title)
    }
    
    func test_CreateAnnotation() {
        let annotation = controller?.createAnnotation(point: CGPoint(x: 20.0, y: 30.5))
        XCTAssertNotNil(annotation)
    }
    
    func test_UpdateAddAnnotation() {
        controller?.updateAnnotation(shouldAdd: true, annotation: MKPointAnnotation())
        XCTAssertTrue(controller?.mapView.annotations.count ?? 0 > 0)
    }
    
    
    func test_UpdateRemoveAnnotation() {
        let newAnnotation = MKPointAnnotation()
        controller?.updateAnnotation(shouldAdd: false, annotation: newAnnotation)
        let expectation = controller?.mapView.annotations.contains(where: { (annotation) -> Bool in
            annotation.isEqual(newAnnotation)
        })
        XCTAssertTrue(expectation == false)
    }
}

extension LocationViewControllerTests {
    func getController() -> UINavigationController {
        let annotation = MKPointAnnotation()
        let viewModel = LocationViewModel(annotations: [annotation])
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
        controller?.viewModel = viewModel
        controller?.loadViewIfNeeded()
        return UINavigationController(rootViewController: controller!)
    }
}
