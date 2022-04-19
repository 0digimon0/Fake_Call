//
//  SettingSelectionCell.swift
//  FakeCall
//
//  Created by admin on 3/16/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class SettingSelectionCell: UITableViewCell {
    public static var identifier = "SettingSelectionCell"
    var isSelectedCell: Bool = false
    
    lazy var label:UILabel = {
        let label = UILabel()
        label.applyContentFont()
        
        return label
    }()
    
    lazy var selectedIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(asset: Asset.icTicked)
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initViews() {
        addSubview(selectedIcon)
        selectedIcon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(15)
        }
        selectedIcon.isHidden = true
        
        addSubview(label)
        label.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(selectedIcon.snp.trailing).offset(15)
            make.centerY.equalTo(self)
        }
    }

    func setCellSlected(isSelected: Bool) {
        isSelectedCell = isSelected
        selectedIcon.isHidden = !isSelected
    }
}
