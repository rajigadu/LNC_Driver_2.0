//
//  AcceptedRidesInfoTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import UIKit

class AcceptedRidesInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_RideDateRef: UILabel!
    @IBOutlet weak var lbl_RideInfoRef: UILabel!
    @IBOutlet weak var lbl_RideDistanceRef: UILabel!
    @IBOutlet weak var btn_RoleChangeBtnRef: UIButton!
    @IBOutlet weak var btn_ViewRideDetailsRef: UIButton!
    @IBOutlet weak var RoleChangeBtnHeight_ref: NSLayoutConstraint!
    @IBOutlet weak var backViewBtn_height_ref: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
