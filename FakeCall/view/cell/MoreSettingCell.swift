//
//  MoreSettingCell.swift
//  FakeCall
//
//  Created by admin on 4/29/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class MoreSettingCell: UITableViewCell {
    static let identifier = "MoreSettingCell"
    
    lazy var switchBtn:UISwitch = {
        let _switchBtn = UISwitch()
        _switchBtn.isOn = false
        _switchBtn.onTintColor = UIColor.orange
        return _switchBtn
    }()
    
    lazy var tripleTapLabel:UITextView = {
        let lb = UITextView()
        lb.applyContentFont()
        lb.text = L10n.Setting.tripleTapToCancel
        lb.sizeToFit()
        lb.isEditable = false
        return lb
    }()
    
    let container = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubview(container)
        container.snp.makeConstraints{(make) -> Void in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalToSuperview()
        }
        
        container.addSubview(switchBtn)
        switchBtn.snp.makeConstraints{(make) -> Void in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(container.snp.centerY)
        }
        switchBtn.addTarget(self, action: #selector(switchIsChanged(_:)), for: .valueChanged)
        
        container.addSubview(tripleTapLabel)
        tripleTapLabel.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(switchBtn.snp.leading).offset(0)
            make.centerY.equalTo(container.snp.centerY)
            make.height.equalToSuperview()
//            make.width.equalToSuperview().offset(-100)
        }
    }
    
    @objc func switchIsChanged(_ sender: UISwitch) {
        DataCallSetting.sharedData.settingObject.isCancelable = sender.isOn
    }
}
