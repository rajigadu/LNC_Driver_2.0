//
//  MenuSliderTableViewCell.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import UIKit

class MenuSliderTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_MenuSliderRef: UILabel!
    @IBOutlet weak var imageview_MenuSliderRef: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

