//
//  Protocols.swift
//  FakeCall
//
//  Created by admin on 3/26/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation

protocol ItemSettingSelected {
    func onItemSelected(index:Int)
}

protocol OptionSelected {
    func onOptionSelected(settingType: Settings, index selected:Int)
}

protocol CallerInformationSetting {
    func onInformationChanged(name: String, data: Data?)
}

