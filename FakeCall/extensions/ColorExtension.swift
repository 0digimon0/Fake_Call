//
//  ColorExtension.swift
//  Fake Call Funy
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension UIImageView {
    func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}

let appFontName = "ArialMT"
let appItalicFontName = "Arial-ItalicMT"

extension UILabel {
    func applyHeaderFont() {
        self.font = UIFont(name: appFontName, size: 19.0)
    }
    
    func applyContentFont() {
        self.font = UIFont(name: appFontName, size: 16.0)
    }
    
    func applySettingSelectedFont() {
        self.font = UIFont(name: appItalicFontName, size: 15)
        self.textColor = UIColor(named: ColorName.settingSelected)
    }
    
    func applyFontWithColorAndSize(color: UIColor, sized: CGFloat) {
        self.font = UIFont(name: appFontName, size: sized)
        self.textColor = color
    }
    
    func applyItalicFontWithColorAndSize(color: UIColor, sized: CGFloat) {
        self.font = UIFont(name: appItalicFontName, size: sized)
        self.textColor = color
    }
}

extension UITextView {
    func applyHeaderFont() {
        self.font = UIFont(name: appFontName, size: 19.0)
    }
    
    func applyContentFont() {
        self.font = UIFont(name: appFontName, size: 16.0)
    }
    
    func applySettingSelectedFont() {
        self.font = UIFont(name: appItalicFontName, size: 15)
        self.textColor = UIColor(named: ColorName.settingSelected)
    }
    
    func applyFontWithColorAndSize(colorNamed: String, sized: CGFloat) {
        self.font = UIFont(name: appFontName, size: sized)
        self.textColor = UIColor(named: colorNamed)
    }
    
    func applyItalicFontWithColorAndSize(color: UIColor, sized: CGFloat) {
        self.font = UIFont(name: appItalicFontName, size: sized)
        self.textColor = color
    }
}
