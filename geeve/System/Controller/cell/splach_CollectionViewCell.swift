//
//  splach_CollectionViewCell.swift
//  geeve App
//
//  Created by Dev Navadiiya on 26/02/24.
//

import UIKit

class splach_CollectionViewCell: UICollectionViewCell {

    
    static let identifire = String(describing: splach_CollectionViewCell.self )
    
    
    
 
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var hadeLine: UILabel!
    
    @IBOutlet weak var Discription: UITextView!
    
   
    func setup(_ slide : onbordingslide){
        
        image_view.image = slide.image
        hadeLine.text = slide.tital
        Discription.text = slide.discription
        
    }
     
    
    
   
}
