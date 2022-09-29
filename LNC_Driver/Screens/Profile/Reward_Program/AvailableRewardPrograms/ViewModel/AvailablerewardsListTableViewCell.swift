//
//  AvailablerewardsListTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class AvailablerewardsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_rewardTitle: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var btn_activateInfo: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
