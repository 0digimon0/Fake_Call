//
//  PlayableSettingSelectionCell.swift
//  FakeCall
//
//  Created by admin on 3/17/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import AVFoundation

class PlayableSettingSelectionCell: UITableViewCell {

    public static let identifier = "PlayableSettingSelectionCell"
    let TAG = "PlayableSettingSelectionCell"
    
    var isCellSelected:Bool = false
    var mediaPlayer:AVAudioPlayer?
    var isPlaying:Bool = false
    var soundDataDict:[String: String] = ["name": ""]
    
    var soundUrl = "" {
        didSet {
            if "".elementsEqual(soundUrl) {
                playBtn.isHidden = true
            } else {
                playBtn.isHidden = false
            }
        }
    }
    
    let imgPlay:UIImage = UIImage(asset: Asset.icPlay)
    let imgPause:UIImage = UIImage(asset: Asset.icPause)
    
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
    
    lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(imgPlay, for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        NotificationCenter.default.addObserver(self, selector: #selector(playMedia(_:)), name: Notification.Name.SoundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMedia), name: Notification.Name.CloseSoundNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func initViews() {
        addSubview(playBtn)
        playBtn.snp.makeConstraints{(make) -> Void in
            make.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        playBtn.addTarget(self, action: #selector(onPlayClicked), for: .touchUpInside)
        playBtn.isHidden = true
        
        addSubview(selectedIcon)
        selectedIcon.snp.makeConstraints{(make) -> Void in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(15)
        }
        
        addSubview(label)
        label.snp.makeConstraints{(make) -> Void in
            make.trailing.equalTo(playBtn.snp.leading).offset(5)
            make.leading.equalTo(selectedIcon.snp.trailing).offset(10)
            make.centerY.equalTo(self)
        }
    }
    
    func setCellSlected(isSelected: Bool) {
        isCellSelected = isSelected
        selectedIcon.isHidden = !isSelected
    }
    
    func setEnable(isEnable: Bool) {
        if isEnable {
            label.alpha = 1
        } else {
            label.alpha = 0.5
        }
    }
    
    @objc func onPlayClicked() {
        print("\(TAG) - sound url: \(soundUrl)")
        
        if "".elementsEqual(soundUrl) {
            return
        }
        
        guard mediaPlayer != nil else {
            mediaPlayer = SoundUtils.playAudio(url: soundUrl, volume: 1)
            playBtn.setImage(imgPause, for: .normal)
            postNotification()
            return
        }
        
        if mediaPlayer!.isPlaying {
            SoundUtils.stopAudio(audioPlayer: mediaPlayer)
            playBtn.setImage(imgPlay, for: .normal)
        } else {
            postNotification()
            SoundUtils.playAudio(audioPlayer: mediaPlayer)
            playBtn.setImage(imgPause, for: .normal)
        }
    }
    
    func postNotification() {
        soundDataDict["name"] = soundUrl
        NotificationCenter.default.post(name: NSNotification.Name.SoundNotification, object: nil, userInfo: soundDataDict)
    }
    
    func stopMediaIfNeeded() {
        if let media = mediaPlayer, media.isPlaying {
            SoundUtils.stopAudio(audioPlayer: mediaPlayer)
            playBtn.setImage(imgPlay, for: .normal)
        }
    }
    
    @objc func playMedia(_ notification: NSNotification) {
        if let soundName = notification.userInfo?["name"] as? String {
            if !soundName.elementsEqual(soundUrl) {
//                print("\(TAG) - it not me, stop now")
                stopMediaIfNeeded()
            } else {
//                print("\(TAG) - is me")
            }
        }
    }
    
    @objc func stopMedia() {
        stopMediaIfNeeded()
    }
}
