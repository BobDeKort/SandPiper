//
//  SearchHistorySongCell.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/13/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class SearchHistorySongTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.isUserInteractionEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
