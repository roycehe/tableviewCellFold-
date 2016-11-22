//
//  AFQCell.swift
//  Alamofire使用
//
//  Created by 何晓文 on 2016/11/22.
//  Copyright © 2016年 何晓文. All rights reserved.
//

import UIKit

class AFQCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubView")
        
    }
    
}
