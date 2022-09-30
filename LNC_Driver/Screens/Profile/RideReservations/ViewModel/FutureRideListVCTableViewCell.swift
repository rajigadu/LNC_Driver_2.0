//
//  FutureRideListVCTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 30/09/22.
//

import UIKit

class FutureRideListVCTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_RideDateRef: UILabel!
    @IBOutlet weak var lbl_RideInfoRef: UILabel!
    @IBOutlet weak var lbl_RideDistanceRef: UILabel!
    @IBOutlet weak var btn_StopsRef: UIButton!
    @IBOutlet weak var btn_AcceptRideRef: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
