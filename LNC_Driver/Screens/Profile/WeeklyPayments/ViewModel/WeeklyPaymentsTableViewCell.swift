//
//  WeeklyPaymentsTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class WeeklyPaymentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_fromDate: UILabel!
    @IBOutlet weak var lbl_toDate: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var btn_viewInfo: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
