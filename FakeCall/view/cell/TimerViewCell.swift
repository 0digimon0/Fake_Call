//
//  TimerView.swift
//  Fake Call Funy
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class TimerViewCell: UITableViewCell {
    public static let identifier = "TimerViewCell"
    
    var onDoneSelected:((_ id: Int) -> Void)?
    
    var timerLabel:UILabel = {
        let label = UILabel()
        label.applyContentFont()
        label.text = L10n.Timer.startAfter
        
        return label
    }()
    
    var timeChosen: UILabel = {
        let label = UILabel()
        label.applySettingSelectedFont()
        label.text = "10 seconds"
        label.textAlignment = .right
        return label
    }()
    
    var openIcon: UIImageView = {
        let img = UIImage(asset: Asset.icOpen)
        let imgVIew = UIImageView(image: img)
        return imgVIew
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let container = UIView()
        addSubview(container)
        container.snp.makeConstraints{(make) -> Void in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        container.backgroundColor = UIColor.white
        
        let icon = UIImageView(image: UIImage(asset: Asset.iconTime))
        icon.contentMode = .scaleAspectFit
        container.addSubview(icon)
        icon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalTo(container.snp.centerY)
            make.width.height.equalTo(24)
        }
        
        container.addSubview(timerLabel)
        timerLabel.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.centerY.equalTo(container.snp.centerY)
            make.width.equalTo(100)
        }
        
        container.addSubview(openIcon)
        openIcon.snp.makeConstraints{(make) -> Void in
            make.trailing.equalToSuperview().inset(5)
            make.width.height.equalTo(16)
            make.centerY.equalTo(container.snp.centerY)
        }
        
        container.addSubview(timeChosen)
        timeChosen.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(timerLabel.snp.trailing).offset(10)
            make.trailing.equalTo(openIcon.snp.leading).offset(-5)
            make.centerY.equalTo(container.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSelectedValue(value: String) {
        timeChosen.text = value
    }
}
