//
//  MealTableViewCell.swift
//  RememberView
//
//  Created by pegasus on 2016/11/26.
//  Copyright © 2016年 Kelly. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
  
  // MARK: Outlets
  
  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var imgviewPhoto: UIImageView!
  
  @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
