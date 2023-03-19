//
//  DBHRideHistoryTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import UIKit

class DBHRideHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_JourneyDateRef: UILabel!
    @IBOutlet weak var lbl_RideInfoRef: UILabel!
    @IBOutlet weak var lbl_DistanceRef: UILabel!
    @IBOutlet weak var NumbAdditionalstopsRef: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
