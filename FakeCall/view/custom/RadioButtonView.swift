//
//  RadioButtonView.swift
//  FakeCall
//
//  Created by admin on 3/18/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class RadioButtonView: UIView {

    var onChecked:(() -> Void)?
    
    var imageRadio: UIImageView = UIImageView()
    let imgRadioOff = UIImage(asset: Asset.icRadioButtonOff)
    let imgRadioOn = UIImage(asset: Asset.icRadioButtonOn)
    
    var isChecked = false
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initViews() {
        addSubview(label)
        label.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalToSuperview().offset(10)
        }
        
        addSubview(imageRadio)
        imageRadio.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.width.height.equalTo(24)
        }
        
        let touchView = UIButton()
        addSubview(touchView)
        touchView.snp.makeConstraints{(make) -> Void in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        touchView.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        updateState()
    }
    
    func updateState() {
        if isChecked {
            imageRadio.image = imgRadioOn
        } else {
            imageRadio.image = imgRadioOff
        }
    }
    
    func setCheck(isCheck:Bool) {
        isChecked = isCheck
        updateState()
    }
    
    @objc func onClick() {
        if !isChecked {
            isChecked = true
            updateState()
            onChecked?()
        }
    }
}
