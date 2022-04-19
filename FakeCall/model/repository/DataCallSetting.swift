//
//  DataCallSetting.swift
//  FakeCall
//
//  Created by admin on 3/23/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation

class DataCallSetting {
    public static var sharedData: DataCallSetting = {
        let dataManager = DataCallSetting()
    
        return dataManager
    }()
    
    var settingObject: SettingObject!
    
    init() {
        if settingObject == nil {
            settingObject = SettingObject()
        }
    }
    
    static func getQuickSettings() -> [SettingObject] {
        let mom = SettingObject(name: "Mom", time: 2, ringtone: 3, enviroment: 0)
        let dad = SettingObject(name: "Dad", time: 3, ringtone: 3, enviroment: 0)
        let myLove = SettingObject(name: "My love", time: 4, ringtone: 3, enviroment: 0)
        return [mom, dad, myLove]
    }
}
