//
//  WeatherViewController.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var location: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var weather: UILabel!
    var activityView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var viewModel: WeatherViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp() {
        viewModel?.fetchWeather()
    }

}

extension WeatherViewController: WeatherDisplayable {
    func hideIndicator() {
        activityView.stopAnimating()
    }
    
    func refreshUI() {
        wind.text = viewModel?.wind
        weather.text = viewModel?.main
        temperature.text = viewModel?.temperature
        humidity.text = viewModel?.humidity
        location.text = viewModel?.name
    }
    
    func showIndicator() {
        activityView.frame = view.frame
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        activityView.style = .large
        activityView.color = .yellow
        activityView.backgroundColor = .gray
        activityView.startAnimating()
        view.addSubview(activityView)
    }
    
    func showAlert(_ error: NetworkError?) {
        let message = error == NetworkError.decodingError ? "System Error" : "Network Unavailable"
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

