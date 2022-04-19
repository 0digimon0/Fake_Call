//
//  SettingObject.swift
//  FakeCall
//
//  Created by admin on 3/26/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation

class SettingObject: NSObject {
    @objc dynamic var timerIndex:Int = 0 {
        didSet {
            switch timerIndex {
            case 0:
                timerValue = 10
            case 1:
                timerValue = 30
            case 2:
                timerValue = 60
            case 3:
                timerValue = 300
            case 4:
                timerValue = 600
            default:
                print("--other")
            }
        }
    }
    var timerValue:Int = 10
    @objc dynamic var contactName:String = ""
    @objc dynamic var ringtoneIndex:Int = 0
    @objc dynamic var callerVoiceIndex:Int = 0
    @objc dynamic var enviromentIndex:Int = 0
    @objc dynamic var wallpaperIndex:Int = 0
    var isCancelable:Bool = false
    var avatarData:Data?
    
    override init() {
    }
    
    init(name: String, time: Int, ringtone: Int, enviroment: Int) {
        super.init()
        self.contactName = name
        self.enviromentIndex = enviroment
        self.ringtoneIndex = ringtone
        setTimerValue(newValue: time)
    }
    
    func setTimerValue(newValue: Int) {
        self.timerIndex = newValue
    }
}
