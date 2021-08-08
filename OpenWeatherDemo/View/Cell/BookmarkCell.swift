//
//  BookmarkCell.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/6/21.
//

import UIKit

class BookmarkCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var lat: UILabel!
    @IBOutlet var lon: UILabel!
    
    var viewModel: BookmarkCellViewModel? {
        didSet {
            configure()
        }
    }

    func configure() {
        title.text = viewModel?.title
        lat.text = viewModel?.lat
        lon.text = viewModel?.lon
    }

}
