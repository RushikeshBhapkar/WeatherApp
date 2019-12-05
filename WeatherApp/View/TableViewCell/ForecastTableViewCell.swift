//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Rushikesh on 05/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var prepLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
