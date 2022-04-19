//
//  CallingControlCell.swift
//  FakeCall
//
//  Created by admin on 4/27/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class CallingControlCell: UICollectionViewCell {
    static let TAG = "CallingControlCell"
    
    var cellWidth:CGFloat = 0
    var cellHeight:CGFloat = 0
    var cellIndex = 0 {
        didSet {
            settingData()
        }
    }
    
    lazy var btnImage: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(asset: Asset.icSelectContact), for: .normal)
        return btn
    }()
    
    var textImage: UILabel = {
        let text = UILabel()
        CommonTextStyles.CallingImageTextStyle.apply(to: text)
        text.text = L10n.Calling.accept
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellWidth = frame.size.width
        cellHeight = frame.size.height
        initViews()
//        settingData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initViews() {
        addSubview(btnImage)
        btnImage.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(cellWidth*0.75)
        }
        
        addSubview(textImage)
        textImage.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(btnImage.snp.bottom).offset(2)
            make.centerX.equalTo(btnImage)
        }
    }
    
    func settingData() {
        switch cellIndex {
        case 0:
            textImage.text = L10n.Calling.mute
            btnImage.setImage(UIImage(asset: Asset.icMute), for: .normal)
        case 1:
            textImage.text = L10n.Calling.keypad
            btnImage.setImage(UIImage(asset: Asset.icKeypad), for: .normal)
        case 2:
            textImage.text = L10n.Calling.audio
            btnImage.setImage(UIImage(asset: Asset.icSpeaker), for: .normal)
        case 3:
            textImage.text = L10n.Calling.addCall
            btnImage.setImage(UIImage(asset: Asset.icAdd), for: .normal)
        case 4:
            textImage.text = L10n.Calling.facetime
            btnImage.setImage(UIImage(asset: Asset.icFaceTime), for: .normal)
        case 5:
            textImage.text = L10n.Calling.contacts
            btnImage.setImage(UIImage(asset: Asset.icContact1), for: .normal)
        default:
             textImage.text = "mute"
        }
    }
}
