//
//  UIViewExtensions.swift
//  instame
//
//  Created by Miles Alden on 11/6/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import Foundation
import UIKit


// https://stackoverflow.com/questions/7022656/calayer-add-a-border-only-at-one-side
// Quick border adding extension
extension UIView {
    @discardableResult func addRightBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: self.frame.size.width-width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(layer)
        return self
    }
    @discardableResult func addLeftBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(layer)
        return self
    }
    @discardableResult func addTopBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(layer)
        return self
    }
    @discardableResult func addBottomBorder(color: UIColor, width: CGFloat) -> UIView {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(layer)
        return self
    }
    
    func addBottomBorder(color: UIColor, width: CGFloat, inset : CGFloat ) -> CALayer {
        let layer = CALayer()
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.frame = CGRect(x: 0 + inset, y: self.frame.size.height-width, width: self.frame.size.width - (inset * 2), height: width)
        self.layer.addSublayer(layer)
        return layer
    }
}
