//
//  SettingHeaderCell.swift
//  Fake Call Funy
//
//  Created by admin on 3/8/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class SettingHeaderCell: UITableViewCell {
    public static let identifier = "SettingHeaderCell"
    
    let cellTitle: UILabel = {
        let title = UILabel()
        title.textColor = MyColors.HeaderTextColor
        title.font = UIFont.systemFont(ofSize: 13)
        title.text = ""
        return title
    }()
    
    let background = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initViews() {
        addSubview(background)
        background.snp.makeConstraints{(make) -> Void in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        background.addSubview(cellTitle)
        cellTitle.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
        background.backgroundColor = MyColors.BackgroundColor
    }
    
    func setHeaderTitle(title: String) {
        cellTitle.text = title.uppercased()
    }
    
    func setHeaderHeight(height: Int) {
        background.snp.updateConstraints{(make) -> Void in
            make.height.equalTo(height)
        }
    }

}
