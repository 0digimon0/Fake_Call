//
//  HomeViewModel.swift
//  FakeCall
//
//  Created by admin on 3/15/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation

class HomeViewModel {
    var settingObject:SettingObject?
    
    init() {
        settingObject = SettingObject()
    }
}

class WaitingViewModel {
    var settingObject:SettingObject?
    
    init() {
        settingObject = SettingObject()
    }
    
    init(object: SettingObject) {
        self.settingObject = object
    }
}

class SelectionViewModel {
    var settingType:Settings!
    var data:[String]!
    var isPlayable:Bool!
    var selectedPosition:Int!
    
    init() {
        settingType = .Time
        data = []
        isPlayable = false
        selectedPosition = 0
    }
}

class SelectionPlayableViewModel: SelectionViewModel {
    var soundUrls:[Int:String]!
    
    override init() {
        super.init()
        self.isPlayable = true
        self.soundUrls = [:]
    }
}

class SelectionNonPlayableViewModel: SelectionViewModel {
    override init() {
        super.init()
        self.isPlayable = false
    }
}

class WallpaperViewModel {
    var settingType:Settings!
    var selectedPosition:Int!
    
    init() {
        settingType = .Wallpaper
        selectedPosition = 0
    }
}

class ContactInforViewModel {
    var contactName:String!
    var contactImage:Data?
    
    init() {
        contactName = ""
    }
}
