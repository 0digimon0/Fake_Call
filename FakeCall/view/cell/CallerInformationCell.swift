//
//  CallerInformationCell.swift
//  FakeCall
//
//  Created by admin on 6/16/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

class CallerInformationCell: UITableViewCell {
    
    public static let identifier = "CallerInformationCell"
    
    let callerTitle: UILabel = {
        let input = UILabel()
        input.applyContentFont()
        input.text = "Caller"
        return input
    }()
    
    let callerSelected: UILabel = {
        let input = UILabel()
        input.applySettingSelectedFont()
        input.text = L10n.Contact.caution2
        input.textAlignment = .right
        return input
    }()
    
    var openIcon: UIImageView = {
        let img = UIImage(named: "ic_open")
        let imgVIew = UIImageView(image: img)
        return imgVIew
    }()
    
    let labelCaution: UILabel = {
        let caution = UILabel()
        caution.font = UIFont.italicSystemFont(ofSize: 13)
        caution.textColor = UIColor(named: ColorName.settingSelected)
        caution.text = L10n.Contact.caution
        return caution
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
        
        let icon = UIImageView(image: UIImage(asset: Asset.iconContact))
        icon.contentMode = .scaleAspectFit
        addSubview(icon)
        icon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        addSubview(callerTitle)
        callerTitle.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(callerSelected)
        callerSelected.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(callerTitle.snp.trailing).offset(10)
            make.trailing.equalTo(openIcon.snp.leading).offset(-5)
            make.centerY.equalTo(callerTitle.snp.centerY)
        }
    }
    
    func setSelectedValue(value: String) {
        if !"".elementsEqual(value) {
            callerSelected.text = value
        } else {
            callerSelected.text = L10n.Contact.caution2
        }
    }
    
}
