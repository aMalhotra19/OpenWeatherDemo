//
//  LocationViewController.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import UIKit
import MapKit
class LocationViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet var mapView: MKMapView!
    var viewModel: LocationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        if let annotations = viewModel?.annotations, annotations.count > 0 {
        addExistingAnnotation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let viewModel = viewModel else {return}
        viewModel.updateAnnotation()
    }
    
    func setUp() {
        title = "Location"
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(recogniser:)))
        gesture.delegate = self
        gesture.minimumPressDuration = 1
        mapView.addGestureRecognizer(gesture)
    }
}

extension LocationViewController {
    
    func addExistingAnnotation() {
        guard let annotations = viewModel?.annotations else {return}
        for annotation in annotations {
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc func addAnnotation(recogniser: UITapGestureRecognizer) {
        let annotation = createAnnotation(point: recogniser.location(in: mapView))
        showAlert(annotation: annotation, add: true)
    }
    
    func createAnnotation(point: CGPoint) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        let tapPoint = mapView.convert(point, toCoordinateFrom: mapView)
        let location = CLLocationCoordinate2D(latitude: tapPoint.latitude, longitude: tapPoint.longitude)
        let loc = CLLocation(latitude: tapPoint.latitude, longitude: tapPoint.longitude)
        CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) -> Void in
            if error == nil {
                annotation.coordinate = location
                // Placemark data includes information such as the country, state, city, and street address associated with the specified coordinate.
                let placemark = CLPlacemark(placemark: placemarks![0] )
                let city = placemark.subAdministrativeArea
                let state = placemark.administrativeArea
                annotation.title = city ?? "Unnamed location"
                annotation.subtitle = state ?? "Unnamed location"
            }
        })
        return annotation
    }

    func updateAnnotation(shouldAdd: Bool, annotation: MKAnnotation) {
        if shouldAdd {
            viewModel?.annotations.append(annotation)
            self.mapView.addAnnotation(annotation)
        } else {
            viewModel?.annotations.removeAll { $0.isEqual(annotation) }
            self.mapView.removeAnnotation(annotation)
        }
    }
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        showAlert(annotation: view.annotation!, add: false)
    }
    
    func showAlert(annotation: MKAnnotation, add: Bool) {
        let message = add == true ? "You want to add annotation" : "You want to remove annotation"
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default) { _ in
            self.updateAnnotation(shouldAdd: add, annotation: annotation)
        }
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
