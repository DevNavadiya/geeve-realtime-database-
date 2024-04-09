//
//  Extionsion.swift
//  geeve App
//
//  Created by Dev Navadiiya on 29/02/24.
//

import Foundation
import UIKit

extension UIView  {
// MARK: - cornerRadius -
    @IBInspectable var cornerRadius : CGFloat{
        
        get{return self.cornerRadius}
        set{self.layer.cornerRadius = newValue}
    }
    
    // MARK: - cornerRadius like a Capsul -
    @IBInspectable var makeACapsul : CGFloat{
        
        get{return self.makeACapsul}
        set{self.layer.cornerRadius = self.frame.height /  newValue}
    }

    // MARK: - shadowOpacity -
    
    @IBInspectable var shadowOpacity : CGFloat {
        
        get {
               return CGFloat(self.layer.shadowOpacity)
           }
           set {
               self.layer.shadowOpacity = Float(newValue)
           }
    }
    
    // MARK: - shadowRadius -
    
    @IBInspectable var shadowRadius : CGFloat {
        
        get{return self.shadowRadius}
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    // MARK: - shadowColor -
    
    @IBInspectable var shadowColor : UIColor {
        
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return UIColor.black // Default color if not set
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    // MARK: - shadow Up And DownOffset -
    
    @IBInspectable var shadowUpAndDownOffset: CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.shadowOffset = CGSize(width: 0.0, height: newValue)
        }
    }

    // MARK: - shadow Right And LeftOffset -
    
    @IBInspectable var shadowRightAndLeftOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    // MARK: - 4 side cornerRadius
     
    @IBInspectable var TopLeft: CGFloat {
           get { return layer.cornerRadius }
           set { layer.cornerRadius = newValue }
       }
       
       @IBInspectable var TopRight: CGFloat {
           get { return layer.cornerRadius }
           set { layer.maskedCorners = [.layerMaxXMinYCorner]; layer.cornerRadius = newValue }
       }
       
       @IBInspectable var BottomLeft: CGFloat {
           get { return layer.cornerRadius }
           set { layer.maskedCorners = [.layerMinXMaxYCorner]; layer.cornerRadius = newValue }
       }
       
       @IBInspectable var BottomRight: CGFloat {
           get { return layer.cornerRadius }
           set { layer.maskedCorners = [.layerMaxXMaxYCorner]; layer.cornerRadius = newValue }
       }
   
}



