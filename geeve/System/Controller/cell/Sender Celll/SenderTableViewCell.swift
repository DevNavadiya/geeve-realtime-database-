//
//  SenderTableViewCell.swift
//  geeve
//
//  Created by Dev Navadiya on 09/04/24.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    @IBOutlet weak var sendermassage: UILabel!
    
    func configure(with message: Chat) {
           sendermassage.text = message.message
           // Configure other UI elements with message data as needed
       }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
