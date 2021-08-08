//
//  LocationViewModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import Foundation
import MapKit

protocol BookmarkDisplayable {
    func refresh()
}

class LocationViewModel {
    
    var bookmarks = [Bookmark]()
    var annotations: [MKAnnotation]
    var delegate: BookmarkDisplayable?
    
    init(annotations: [MKAnnotation] = BookmarkManager.shared.annotations) {
        self.annotations = annotations
    }
   
    func updateAnnotation() {
        BookmarkManager.shared.annotations = annotations
    }
}
