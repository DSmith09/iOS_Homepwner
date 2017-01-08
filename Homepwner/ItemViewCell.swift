//
//  ItemViewCell.swift
//  Homepwner
//
//  Created by David on 1/8/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Support for Dynamic Type Accessibility
    open func updateLabels() -> Void {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        serialNumberLabel.font = caption1Font
    }

}
