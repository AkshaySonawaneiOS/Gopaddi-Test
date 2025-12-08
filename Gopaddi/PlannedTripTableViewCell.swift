//
//  PlannedTripTableViewCell.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 07/12/25.
//

import UIKit

class PlannedTripTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTripDays: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblTripName: UILabel!
    @IBOutlet weak var imgDestination: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnViewClicked(_ sender: Any) {
    }
}
