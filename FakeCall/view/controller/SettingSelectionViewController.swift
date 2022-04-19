//
//  SettingSelectionViewController.swift
//  FakeCall
//
//  Created by admin on 3/14/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class SettingSelectionViewController: UIViewController {
    static var TAG = "SettingSelectionViewController"
    
    var selectionList: UITableView!
    var viewModel:SelectionViewModel!
    var listener: OptionSelected?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        selectedIndex = viewModel.selectedPosition
        
        selectionList = UITableView()
        selectionList.dataSource = self
        selectionList.delegate = self
        selectionList.separatorStyle = .singleLine
        selectionList.register(SettingSelectionCell.self, forCellReuseIdentifier: SettingSelectionCell.identifier)
        selectionList.register(PlayableSettingSelectionCell.self, forCellReuseIdentifier: PlayableSettingSelectionCell.identifier)
        selectionList.tableFooterView = UIView()

        view.addSubview(selectionList)
        selectionList.snp.makeConstraints{(make) -> Void in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let buttonStart = UIBarButtonItem(title: L10n.done, style: .plain, target: self, action: #selector(onDoneSelected))
        self.navigationItem.rightBarButtonItem  = buttonStart
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name.CloseSoundNotification, object: nil, userInfo: nil)
    }
    
    @objc func onDoneSelected() {
        listener?.onOptionSelected(settingType: viewModel.settingType, index: selectedIndex)
        navigationController?.popViewController(animated: true)
    }

}

extension SettingSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.isPlayable {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingSelectionCell.identifier, for: indexPath) as! SettingSelectionCell
            cell.label.text = viewModel.data[indexPath.row]
            cell.selectionStyle = .none
            if selectedIndex == indexPath.row {
                cell.setCellSlected(isSelected: true)
            } else {
                cell.setCellSlected(isSelected: false)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayableSettingSelectionCell.identifier, for: indexPath) as! PlayableSettingSelectionCell
            cell.label.text = viewModel.data[indexPath.row]
            cell.selectionStyle = .none
            
            cell.soundUrl = (viewModel as! SelectionPlayableViewModel).soundUrls[indexPath.row] ?? ""
            if selectedIndex == indexPath.row {
                cell.setCellSlected(isSelected: true)
            } else {
                cell.setCellSlected(isSelected: false)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
}
