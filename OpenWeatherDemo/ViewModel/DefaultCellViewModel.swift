//
//  defaultCellViewModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/6/21.
//

import Foundation

class DefaultCellViewModel: RowDisplayable {
    let rowType: RowType = .defaultCell
    var title: String
    init(title: String) {
        self.title = title
    }
    
}
