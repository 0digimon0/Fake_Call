//
//  WallpaperSelectionCell.swift
//  FakeCall
//
//  Created by admin on 6/18/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

class WallpaperSelectionCell: UITableViewCell {

    public static let identifier = "WallpaperSelectionCell"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var onDoneSelected:((_ id: Int) -> Void)?
    
    var timerLabel:UILabel = {
        let label = UILabel()
        label.applyContentFont()
        label.text = L10n.Wallpaper.name
        
        return label
    }()
    
    var timeChosen: UILabel = {
        let label = UILabel()
        label.applySettingSelectedFont()
        label.text = "background 1"
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
        
        let icon = UIImageView(image: UIImage(asset: Asset.iconWallpaper))
        icon.contentMode = .scaleAspectFit
        addSubview(icon)
        icon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        self.addSubview(timerLabel)
        timerLabel.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        
        self.addSubview(openIcon)
        openIcon.snp.makeConstraints{(make) -> Void in
            make.trailing.equalToSuperview().inset(5)
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(timeChosen)
        timeChosen.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(timerLabel.snp.trailing).offset(10)
            make.trailing.equalTo(openIcon.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
        }
    }
    
    func setSelectedValue(value: String) {
        timeChosen.text = value
    }

}
