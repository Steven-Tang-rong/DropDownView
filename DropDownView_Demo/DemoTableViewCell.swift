//
//  DemoTableViewCell.swift
//  DropDownView_Demo
//
//  Created by StevenTang on 2022/3/16.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    let demoLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        demoLabel.frame.size = CGSize(width: 50.0, height: 50.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
