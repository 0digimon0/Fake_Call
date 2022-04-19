//
//  SelectionWithSwitchCell.swift
//  FakeCall
//
//  Created by admin on 5/11/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

class SelectionWithSwitchCell: UITableViewCell {
    
    static let identifier = "SelectionWithSwitchCell"
    
    var ringtoneProtocol:RingtoneSettingChanged?
    var index:Int = 0
    
    lazy var switchBtn:UISwitch = {
        let _switchBtn = UISwitch()
        _switchBtn.isOn = false
        _switchBtn.onTintColor = UIColor.orange
        return _switchBtn
    }()
    
    lazy var contentLabel:UILabel = {
        let lb = UILabel()
//        lb.text = L10n.Setting.tripleTapToCancel
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
        
        container.addSubview(contentLabel)
        contentLabel.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(switchBtn.snp.leading).offset(0)
            make.centerY.equalTo(container.snp.centerY)
            make.height.equalToSuperview()
        }
    }
    
    @objc func switchIsChanged(_ sender: UISwitch) {
        ringtoneProtocol?.onSwitchChanged(isOn: sender.isOn, index: index)
    }
    
    func setProtocolWithIndex(setingProtocol: RingtoneSettingChanged, index: Int) {
        self.ringtoneProtocol = setingProtocol
        self.index = index
    }
    
    func isTurnOn(isOn:Bool) {
        switchBtn.setOn(isOn, animated: true)
    }
    
}
