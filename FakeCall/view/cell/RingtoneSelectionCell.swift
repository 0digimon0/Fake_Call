//
//  RingtoneSelectionCell.swift
//  Fake Call Funy
//
//  Created by admin on 3/8/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

class RingtoneSelectionCell: UITableViewCell {

    public static let identifier = "RingtoneSelectionCell"
    
    let ringtoneTitle: UILabel = {
        let input = UILabel()
        input.applyContentFont()
        input.text = L10n.Ringtone.name
        return input
    }()
    
    let ringtoneSelected: UILabel = {
        let input = UILabel()
        input.applySettingSelectedFont()
        input.text = L10n.none
        return input
    }()
    
    var openIcon: UIImageView = {
        let img = UIImage(named: "ic_open")
        let imgVIew = UIImageView(image: img)
        return imgVIew
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initViews() {
        addSubview(openIcon)
        openIcon.snp.makeConstraints{(make) -> Void in
            make.trailing.equalToSuperview().offset(-5)
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        let icon = UIImageView(image: UIImage(asset: Asset.iconRingtone))
        icon.contentMode = .scaleAspectFit
        addSubview(icon)
        icon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        addSubview(ringtoneTitle)
        ringtoneTitle.snp.makeConstraints{(make) -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
        
        addSubview(ringtoneSelected)
        ringtoneSelected.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(ringtoneTitle.snp.trailing).offset(10)
            make.trailing.equalTo(openIcon.snp.leading).offset(-5)
            make.centerY.equalTo(ringtoneTitle.snp.centerY)
        }
    }
    
    func setSelectedValue(value: String) {
        ringtoneSelected.text = value
    }
}
