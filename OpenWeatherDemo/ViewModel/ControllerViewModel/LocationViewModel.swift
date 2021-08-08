//
//  LocationViewModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import Foundation
import MapKit

class LocationViewModel {
    var annotations: [MKAnnotation]
    
    init(annotations: [MKAnnotation] = BookmarkManager.shared.annotations) {
        self.annotations = annotations
    }
   
    func updateAnnotation() {
        BookmarkManager.shared.annotations = annotations
    }
}
