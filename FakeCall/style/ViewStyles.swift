//
//  ViewStyles.swift
//  My Diary
//
//  Created by admin on 7/6/19.
//  Copyright © 2019 com.digimon. All rights reserved.
//

import Foundation
import UIKit

struct CommonStyle {
    static let RoundedButtonStyle: UIViewStyle<UIButton> = UIViewStyle { button in
        button.backgroundColor = MyColors.ColorPrimary
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    static let RectangleButtonStyle: UIViewStyle<UIButton> = UIViewStyle { button in
        button.backgroundColor = MyColors.ColorPrimary
        button.setTitleColor(UIColor.white, for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

}

struct CommonTextStyles {
    static let TimeTextStyle: UIViewStyle<UILabel> = UIViewStyle { text in
        text.textColor = UIColor.darkGray
        text.font = UIFont.italicSystemFont(ofSize: 14)
    }
    
    static let CallingImageTextStyle: UIViewStyle<UILabel> = UIViewStyle { text in
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 15)
        text.textAlignment = .center
    }
    
    static let CallingImageTextStyle2: UIViewStyle<UILabel> = UIViewStyle { text in
        text.textColor = UIColor.white
        text.font = UIFont.systemFont(ofSize: 13)
        text.textAlignment = .center
    }
}
