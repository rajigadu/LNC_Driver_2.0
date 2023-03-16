//
//  AssignRidesTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/03/23.
//

import UIKit

class AssignRidesTableViewCell: UITableViewCell {

    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var pickUpAddressLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
