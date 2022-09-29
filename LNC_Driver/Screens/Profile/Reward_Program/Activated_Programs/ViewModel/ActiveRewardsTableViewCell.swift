//
//  ActiveRewardsTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class ActiveRewardsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_dateTime: UILabel!
    @IBOutlet weak var lbl_progTitle: UILabel!
    @IBOutlet weak var lbl_totalPoints: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var btn_ViewInfo: UIButton!
    @IBOutlet weak var lbl_totalEarnpointsref: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
