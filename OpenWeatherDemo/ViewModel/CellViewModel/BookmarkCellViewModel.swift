//
//  BookmarkCellViewModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/6/21.
//

import Foundation

class BookmarkCellViewModel: RowDisplayable {
    let rowType: RowType = .bookmark
    var title: String
    var lat: String
    var lon: String
    
    init(title: String, lat: String, lon: String) {
        self.title = title
        self.lat = lat
        self.lon = lon
    }
}
