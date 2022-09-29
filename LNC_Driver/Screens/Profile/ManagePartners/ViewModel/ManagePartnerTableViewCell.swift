//
//  ManagePartnerTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class ManagePartnerTableViewCell: UITableViewCell {

    @IBOutlet weak var switch_Ref: UISwitch!
    @IBOutlet weak var lbl_PartnerNameRef: UILabel!
    @IBOutlet weak var lbl_PartnerNumberRef: UILabel!
    @IBOutlet weak var lbl_PartnerEmailRef: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
