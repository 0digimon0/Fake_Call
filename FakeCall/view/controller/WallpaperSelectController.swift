//
//  WallpaperSelectController.swift
//  FakeCall
//
//  Created by admin on 6/21/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class WallpaperSelectController: UITableViewController {

    var listener: OptionSelected?
    var selectedIndex: Int = 1
    var viewModel:WallpaperViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonStart = UIBarButtonItem(title: L10n.done, style: .plain, target: self, action: #selector(onDoneSelected))
        self.navigationItem.rightBarButtonItem  = buttonStart
        
        selectedIndex = viewModel?.selectedPosition ?? 0
        tableView.register(WallaperItemCell.self, forCellReuseIdentifier: WallaperItemCell.TAG)
        
        tableView.reloadData()
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
//        tableView.delegate?.tableView!(self.tableView, didSelectRowAt: indexPath)
        
    }
    
    @objc func onDoneSelected() {
        listener?.onOptionSelected(settingType: Settings.Wallpaper, index: selectedIndex)
        navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WallaperItemCell.TAG) as! WallaperItemCell
        
        if indexPath.row == 0 {
            cell.imageWallpaper.image = UIImage(asset: Asset.wallpaper1)
        } else {
            cell.imageWallpaper.image = UIImage(asset: Asset.wallpaper2)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}


class WallaperItemCell: UITableViewCell {
    static let TAG:String = "WallaperItemCell"
    
    lazy var imageWallpaper:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(asset: Asset.wallpaper1)
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageWallpaper)
        imageWallpaper.snp.makeConstraints{
            $0.top.equalTo(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(90)
            $0.height.equalTo(160)
        }
        imageWallpaper.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
