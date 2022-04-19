//
//  AdvanceSettingCell.swift
//  Fake Call Funy
//
//  Created by admin on 3/6/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

class VoiceSelectionCell: UITableViewCell {
    public static let identifier = "VoiceSelectionCell"
    
    let voiceTitle: UILabel = {
        let input = UILabel()
        input.applyContentFont()
        input.text = L10n.CallerVoice.name
        return input
    }()
    
    let voiceSelected: UILabel = {
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
        
        let icon = UIImageView(image: UIImage(asset: Asset.iconCaller))
        icon.contentMode = .scaleAspectFit
        addSubview(icon)
        icon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        addSubview(voiceTitle)
        voiceTitle.snp.makeConstraints{(make) -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
        
        addSubview(voiceSelected)
        voiceSelected.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(voiceTitle.snp.trailing).offset(10)
            make.trailing.equalTo(openIcon.snp.leading).offset(-5)
            make.centerY.equalTo(voiceTitle.snp.centerY)
        }
    }

    func setSelectedValue(value: String) {
        voiceSelected.text = value
    }
}
