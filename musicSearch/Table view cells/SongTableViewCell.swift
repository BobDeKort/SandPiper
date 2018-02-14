//
//  SongTableViewCell.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/12/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var availabilityStackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //availabilityStackView.isHidden = true
        
        self.isUserInteractionEnabled = false
        
        availabilityStackView.addArrangedSubview(UIImageView(image: #imageLiteral(resourceName: "spotifySmallIcon")))
        availabilityStackView.addArrangedSubview(UIImageView(image: #imageLiteral(resourceName: "appleMusicSmallIcon")))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
