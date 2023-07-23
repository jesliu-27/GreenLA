//
//  Utility .swift
//  Keep Recycle And Carry On
//
//  Created by Jessica Liu on 10/17/21.
//

import Foundation
import UIKit

class Utility{
    
    static func textField (_ textfield:UITextField){
        let bLine = CALayer()
        bLine.frame = CGRect(x:0, y:textfield.frame.height - 3, width:textfield.frame.width, height:3)
        bLine.backgroundColor = UIColor.init(red: 66, green: 222, blue: 55, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bLine)

    }
    
    static func FilledButton(_ button:UIButton) {
        
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func BlankButton (_ button:UIButton){
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.black

    }
    
    
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

    
}
