//
//  WeatherViewModelTests.swift
//  OpenWeatherDemoTests
//
//  Created by Anju Malhotra on 8/9/21.
//

import XCTest
import MapKit
@testable import OpenWeatherDemo

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel?
    var controller: WeatherViewController?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.        
        try? super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        viewModel = WeatherViewModel(lat: 25.9, long: 76.1)
        viewModel?.delegate = controller.self
        controller?.viewModel = viewModel
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try? super.tearDownWithError()
    }
    
    func test_FetchWeatherValidResponse() {
        let service = MockLocationService()
        service.shouldReturnError = false
        BookmarkManager.shared.service = service
        viewModel?.fetchWeather()
        XCTAssertNotNil(viewModel?.weatherModel)
        XCTAssertNotNil(viewModel?.name)
        XCTAssertNotNil(viewModel?.humidity)
        XCTAssertNotNil(viewModel?.temperature)
        XCTAssertNotNil(viewModel?.wind)
        XCTAssertNotNil(viewModel?.main)
    }
    
    func test_FetchWeatherInvalidResponse() {
        let service = MockLocationService()
        service.shouldReturnError = true
        BookmarkManager.shared.service = service
        viewModel?.fetchWeather()
        XCTAssertNil(viewModel?.weatherModel)
    }
}


class MockLocationService: LocationService {
    var shouldReturnError: Bool?
    let content = """
    {"coord":{"lon":77.567,"lat":13.2354},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"base":"stations","main":{"temp":297.29,"feels_like":297.8,"temp_min":296.19,"temp_max":297.29,"pressure":1014,"humidity":78},"visibility":6000,"wind":{"speed":7.2,"deg":270},"rain":{"1h":0.28},"clouds":{"all":75},"dt":1628532520,"sys":{"type":1,"id":9208,"country":"IN","sunrise":1628469385,"sunset":1628514851},"timezone":19800,"id":1272473,"name":"Dod Ballāpur","cod":200}
    """
    override func fetchWeather(url: URL, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void) {
        let data = Data(content.utf8)
        let model = (try? JSONDecoder().decode(WeatherModel.self, from: data))!
        shouldReturnError == false ? completion(.success(model)) : completion(.failure(NetworkError.decodingError))
    }
}
