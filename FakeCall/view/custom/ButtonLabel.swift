//
//  ButtonLabel.swift
//  FakeCall
//
//  Created by admin on 4/26/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class ButtonLabel: UIView {

    lazy var btnAccept: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(asset: Asset.icSelectContact), for: .normal)
        return btn
    }()
    
    var textImageAccept: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle.apply(to: text)
        text.text = L10n.Calling.accept
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        print("BL--- did Move To Super view: \(self.frame.size.width)")
    }

    func initViews() {
        print("BL--- init views")
    }
}
