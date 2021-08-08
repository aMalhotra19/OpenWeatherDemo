//
//  DefaultCell.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import UIKit

class DefaultCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
