//
//  ISSCell.swift
//  SpaceStation
//
//  Created by Frederick C. Lee on 1/21/18.
//  Copyright © 2018 Amourine Technologies. All rights reserved.
//

import UIKit

class ISSCell: UITableViewCell {
    @IBOutlet var duration: UILabel!
    @IBOutlet var riseTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
