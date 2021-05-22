//
//  TaskTableViewCell.swift
//  luze-app
//
//  Created by Jiwon You on 18/5/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    @IBOutlet weak var completedBtn: UIButton!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
