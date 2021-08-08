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
        title = "Waather"
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
        configureActivityIndicator()
        navigationController?.view.addSubview(activityView)
    }
    
    func configureActivityIndicator() {
        activityView.frame = view.frame
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        activityView.style = .large
        activityView.color = .yellow
        activityView.backgroundColor = .gray
        activityView.alpha = 0.5
        activityView.startAnimating()
    }
    
    func showAlert(_ error: NetworkError?) {
        // Hide all views in case of error
        for view in view.subviews {
            view.isHidden = true
        }
        let message = error == NetworkError.decodingError ? "System Error" : "Network Unavailable"
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in self.navigationController?.popViewController(animated: true) }))
        present(alert, animated: true, completion: nil)
    }
}

