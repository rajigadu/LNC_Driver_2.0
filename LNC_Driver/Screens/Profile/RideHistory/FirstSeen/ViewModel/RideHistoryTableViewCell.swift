//
//  RideHistoryTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class RideHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_JourneyDateRef: UILabel!
    @IBOutlet weak var lbl_RideInfoRef: UILabel!
    @IBOutlet weak var lbl_DistanceRef: UILabel!
    @IBOutlet weak var NumbAdditionalstopsRef: UILabel!
    @IBOutlet weak var btn_StopActionRef: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
