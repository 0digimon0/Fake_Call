//
//  BaseStyle.swift
//  My Diary
//
//  Created by admin on 7/6/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import Foundation
import UIKit

struct UIViewStyle<T: UIView> {
    let styling: (T)-> Void
    
    static func compose(_ styles: UIViewStyle<T>...)-> UIViewStyle<T> {
        return UIViewStyle { view in
            for style in styles {
                style.styling(view)
            }
        }
    }
    
    func apply(to view: T) {
        styling(view)
    }
}


