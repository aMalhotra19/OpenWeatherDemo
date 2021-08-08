//
//  HomeViewController.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var bookmarkTableView: UITableView!
    var viewModel = HomeViewModel()
    var activityView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(routeToLocationVC))
        // Do any additional setup after loading the view.
        title = "Bookmarks"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }

    override func viewDidDisappear(_ animated: Bool) {
        if activityView.isAnimating {
            hideIndicator()
        }
    }
}

extension HomeViewController {
    
    func refresh() {
        viewModel.annotations = BookmarkManager.shared.annotations
        viewModel.configureBookmarkCellViewModel()
        bookmarkTableView.reloadData()
    }
}

extension HomeViewController {
    
    @objc func routeToLocationVC() {
        showIndicator()
        performSegue(withIdentifier: "LocationSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationSegue" {
        let locationViewModel = LocationViewModel()
        
        let destinationVC = segue.destination as? LocationViewController
        destinationVC?.viewModel = locationViewModel
        } else if segue.identifier == "WeatherSegue"{
            let selectedRow = (sender as? IndexPath)?.row ?? 0
            let selectedAnnotation = viewModel.annotations[selectedRow]
            let destinationVC = segue.destination as? WeatherViewController
            let viewModel = WeatherViewModel(lat: selectedAnnotation.coordinate.latitude, long: selectedAnnotation.coordinate.longitude)
            destinationVC?.viewModel = viewModel
        }
    }
}

extension HomeViewController {
    
    func hideIndicator() {
        activityView.stopAnimating()
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
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.getViewModel(for: indexPath) else {return UITableViewCell()}
        switch cellViewModel.rowType {
        case .defaultCell:
            return getDefaultCell(indexPath: indexPath, viewModel: cellViewModel)
        case .bookmark:
            return getBookmarkCell(indexPath: indexPath, viewModel: cellViewModel)
        }
    }
    
    func getDefaultCell(indexPath: IndexPath, viewModel: RowDisplayable?) -> UITableViewCell {
        guard let cell = bookmarkTableView.dequeueReusableCell(withIdentifier: "\(DefaultCell.self)") as? DefaultCell, let cellViewModel = viewModel as? DefaultCellViewModel else {return UITableViewCell()}
        cell.title.text = cellViewModel.title
        return cell
    }
    
    func getBookmarkCell(indexPath: IndexPath, viewModel: RowDisplayable?) -> UITableViewCell {
        guard let cell = bookmarkTableView.dequeueReusableCell(withIdentifier: "\(BookmarkCell.self)") as? BookmarkCell, let cellViewModel = viewModel as? BookmarkCellViewModel else {return UITableViewCell()}
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WeatherSegue", sender: indexPath)
    }
}
