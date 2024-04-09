//
//  SenderTableViewCell.swift
//  geeve
//
//  Created by Dev Navadiya on 09/04/24.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    @IBOutlet weak var massage: UILabel!
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func gviedata (with chat : chat) {
        self.massage.text = chat.text
    }
}
