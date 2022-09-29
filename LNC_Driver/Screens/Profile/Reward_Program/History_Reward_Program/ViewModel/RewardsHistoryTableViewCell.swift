//
//  RewardsHistoryTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class RewardsHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_dateTime: UILabel!
    @IBOutlet weak var lbl_pickup: UILabel!
    @IBOutlet weak var lbl_dropoff: UILabel!
    @IBOutlet weak var lbl_miles: UILabel!
    @IBOutlet weak var lbl_rewardpoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
