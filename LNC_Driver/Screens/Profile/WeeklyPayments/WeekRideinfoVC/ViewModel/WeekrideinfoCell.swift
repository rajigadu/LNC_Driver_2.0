//
//  WeekrideinfoCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class WeekrideinfoCell: UITableViewCell {
    @IBOutlet weak var lbl_DateRef: UILabel!
    @IBOutlet weak var lbl_PaymentIDRef: UILabel!
    @IBOutlet weak var lbl_AmountRef: UILabel!
    @IBOutlet weak var lbl_RideInfoRef: UILabel!
    @IBOutlet weak var btn_SelfPartnerPaymentRef: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
