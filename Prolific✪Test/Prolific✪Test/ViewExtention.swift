//
//  ViewExtention.swift
//  Prolific✪Test
//
//  Created by Guang on 10/2/16.
//  Copyright © 2016 Guang. All rights reserved.

import Foundation
import UIKit

extension UILabel {
    func popAnimation(book:String, completion: Bool  -> ()) {
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                self.hidden = false
                self.text = book
                UIView.animateWithDuration(2.0, delay:0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.alpha = 1.0
                    }, completion: nil)
                UIView.animateWithDuration(0.7, delay: 1.5, options: .CurveEaseIn, animations: {
                    self.alpha = 0.77
                    }, completion: completion)
        })
    }
}