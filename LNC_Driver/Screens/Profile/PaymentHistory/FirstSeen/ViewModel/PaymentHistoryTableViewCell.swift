//
//  PaymentHistoryTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class PaymentHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_DateRef: UILabel!
    @IBOutlet weak var lbl_PaymentIDRef: UILabel!
    @IBOutlet weak var lbl_AmountRef: UILabel!
    @IBOutlet weak var lbl_RideInfoRef: UILabel!
    @IBOutlet weak var btn_SelfPartnerPaymentRef: UIButton!
    @IBOutlet weak var Amount_hieght_ref: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
