//
//  QuickCallView.swift
//  FakeCall
//
//  Created by admin on 5/28/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class QuickCallView: UIView {
    
    var listener:ItemSettingSelected?
    var index:Int = 0
    var settingData:SettingObject?
    
    lazy var lbName:UILabel = {
        let lb = UILabel()
//        lb.text = "Mom"
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lb.textColor = UIColor.white
        return lb
    }()
    
    lazy var lbSoundSetting:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lb.textColor = UIColor.white
        return lb
    }()
    
    lazy var lbTimeStart:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lb.textColor = UIColor.white
        return lb
    }()
    
    lazy var lbEnviroment:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lb.textColor = UIColor.white
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingViews()
        updateData()
    }
    
    init(object: SettingObject) {
        super.init(frame: .zero)
        
        self.settingData = object
        settingViews()
        updateData()
    }
    
    init(name: String, soundType: String) {
        super.init(frame: .zero)
        
        settingViews()
        lbName.text = name
        lbSoundSetting.text = soundType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData() {
        lbTimeStart.text = "\(L10n.Timer.startAfter): \(DataRepository.sharedData.getListTime()[settingData!.timerIndex])"
        lbName.text = settingData?.contactName ?? ""
        lbSoundSetting.text = "\(L10n.Ringtone.name): \(DataRepository.sharedData.getListRingtone()[settingData?.ringtoneIndex ?? 3])"
        lbEnviroment.text = "\(L10n.Enviroment.name): \(DataRepository.sharedData.getListEnviroment()[settingData?.enviromentIndex ?? 0])"
    }
    
    func settingViews() {
        backgroundColor = UIColor.darkGray
        
        let touchableView = UIButton()
        addSubview(touchableView)
        touchableView.snp.makeConstraints{
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(70)
        }
        touchableView.setTitle(L10n.start, for: .normal)
        touchableView.backgroundColor = UIColor.red
        touchableView.addTarget(self, action: #selector(onTouchUp), for: .touchUpInside)
        
        addSubview(lbName)
        lbName.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(26)
            $0.right.equalTo(touchableView.snp.left).offset(-10)
        }
        
        addSubview(lbSoundSetting)
        lbSoundSetting.snp.makeConstraints{
            $0.top.equalTo(lbName.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(26)
            $0.right.equalTo(touchableView.snp.left).offset(-10)
        }
        
        addSubview(lbEnviroment)
        lbEnviroment.snp.makeConstraints{
            $0.top.equalTo(lbSoundSetting.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(26)
            $0.right.equalTo(touchableView.snp.left).offset(-10)
        }
        
        addSubview(lbTimeStart)
        lbTimeStart.snp.makeConstraints{
            $0.top.equalTo(lbEnviroment.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(26)
            $0.right.equalTo(touchableView.snp.left).offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        
    }
    
    @objc func onTouchUp() {
        listener?.onItemSelected(index: index)
    }
}
