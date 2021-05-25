//
//  ReportTableViewCell.swift
//  mordernizingMedicine
//
//  Created by Setu Desai on 5/14/21.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var lblBloodPressure: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDiaSys: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
