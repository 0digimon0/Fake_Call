//
//  RingtoneSettingViewController.swift
//  FakeCall
//
//  Created by admin on 3/17/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class RingtoneSettingViewController: UIViewController {
    static var TAG = "RingtoneSettingViewController"
    
    var selectionList: UITableView!
    var viewModel:SelectionViewModel!
    var finalPosition:Int = 0
    var listener: OptionSelected?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        
        let buttonStart = UIBarButtonItem(title: L10n.done, style: .plain, target: self, action: #selector(onItemSelected))
        self.navigationItem.rightBarButtonItem  = buttonStart
        
        finalPosition = viewModel.selectedPosition
        
        selectionList = UITableView()
        selectionList.dataSource = self
        selectionList.delegate = self
        selectionList.separatorStyle = .singleLine
        selectionList.register(PlayableSettingSelectionCell.self, forCellReuseIdentifier: PlayableSettingSelectionCell.identifier)
        selectionList.register(SelectionWithSwitchCell.self, forCellReuseIdentifier: SelectionWithSwitchCell.identifier)
        //selectionList.bounces = false
        selectionList.backgroundColor = UIColor.clear
        selectionList.tableFooterView = UIView()
        
        view.addSubview(selectionList)
        selectionList.snp.makeConstraints{(make) -> Void in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name.CloseSoundNotification, object: nil, userInfo: nil)
    }
    
    @objc func onItemSelected() {
        DataCallSetting.sharedData.settingObject.ringtoneIndex = finalPosition
        listener?.onOptionSelected(settingType: Settings.Ringtone, index: finalPosition)
        navigationController?.popViewController(animated: true)
    }
}

extension RingtoneSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return viewModel.data.count - 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectionWithSwitchCell.identifier, for: indexPath) as! SelectionWithSwitchCell
            cell.contentLabel.text = viewModel.data[indexPath.row]
            cell.setProtocolWithIndex(setingProtocol: self, index: indexPath.row)
            cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                cell.isTurnOn(isOn: finalPosition == 0)
            } else if indexPath.row == 1 {
                cell.isTurnOn(isOn: finalPosition == 1)
            } else {
                cell.isTurnOn(isOn: (finalPosition > 2))
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayableSettingSelectionCell.identifier, for: indexPath) as! PlayableSettingSelectionCell
            
            cell.label.text = viewModel.data[indexPath.row + 3]
            cell.soundUrl = (viewModel as! SelectionPlayableViewModel).soundUrls[indexPath.row+3] ?? ""
            cell.selectionStyle = .none
            
            let selected = (finalPosition-3)<0 ? 0:(finalPosition-3)
            if selected == indexPath.row {
                cell.setCellSlected(isSelected: true)
            } else {
                cell.setCellSlected(isSelected: false)
            }
            
            if finalPosition < 2 {
                cell.setEnable(isEnable: false)
            } else {
                cell.setEnable(isEnable: true)
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && finalPosition > 2 {
            finalPosition = indexPath.row + 3
            tableView.reloadData()
        }
    }
}

extension RingtoneSettingViewController: RingtoneSettingChanged {
    func onSwitchChanged(isOn: Bool, index: Int) {
        if index == 0 || index == 1{
            finalPosition = isOn ? index : 3
        } else {
            if finalPosition < 3 {
                finalPosition = 3
            }
        }
        selectionList.reloadData()
    }
}

protocol RingtoneSettingChanged {
    func onSwitchChanged(isOn:Bool, index: Int)
}
