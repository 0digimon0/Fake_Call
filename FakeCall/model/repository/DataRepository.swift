//
//  DataRepository.swift
//  FakeCall
//
//  Created by admin on 3/15/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation

class DataRepository {
    public static var sharedData: DataRepository = {
        let dataManager = DataRepository()
        // Configuration
        // ...
        return dataManager
    }()
    
    var ringtones:[String] = []
    var callerVoices:[String] = []
    var times:[String] = []
    var enviroment:[String] = []
    var wallpaper:[String] = []
    
    var enviromentUrls:Dictionary = [Int:String]()
    var ringtonesUrls:Dictionary = [Int:String]()
    var callerVoiceUrls:Dictionary = [Int:String]()
    
    func getListRingtone() -> [String]{
        if ringtones.count == 0 {
            ringtones.append(L10n.Ringtone.silent)
            ringtones.append(L10n.Ringtone.vibration)
            ringtones.append(L10n.Ringtone.soundVibration)
            ringtones.append(L10n.Ringtone.default)
            ringtones.append(L10n.Ringtone.fastAndSad)
            ringtones.append(L10n.Ringtone.samsung)
            ringtones.append(L10n.Ringtone.mi)
            ringtones.append(L10n.Ringtone.tik)
            
            ringtonesUrls[3] = "mp3_iphone_original"
            ringtonesUrls[4] = "mp3_fast_and_sad"
            ringtonesUrls[5] = "mp3_samsungs20"
            ringtonesUrls[6] = "mp3_mi_ringtone"
            ringtonesUrls[7] = "mp3_tiktok"
        }
        
        return ringtones
    }
    
    func getListCallerVoice() -> [String]{
        if callerVoices.count == 0 {
            callerVoices.append(L10n.none)
            callerVoices.append("Little girl")
            callerVoices.append("Baby")
            callerVoices.append("Crow talking")
            
            callerVoiceUrls[1] = "Little_Girl_Talking"
            callerVoiceUrls[2] = "Baby_Talk"
            callerVoiceUrls[3] = "crow_talking"
        }
        
        return callerVoices
    }
    
    func getListEnviroment() -> [String]{
        if enviroment.count == 0 {
            enviroment.append(L10n.none)
            enviroment.append(L10n.Enviroment.farmville)
            enviroment.append(L10n.Enviroment.beach)
            enviroment.append(L10n.Enviroment.church)
            enviroment.append(L10n.Enviroment.contruction)
            enviroment.append(L10n.Enviroment.rain)
            enviroment.append(L10n.Enviroment.street)
            
            enviromentUrls[1] = "farm"
            enviromentUrls[2] = "mp3_ocean"
            enviromentUrls[3] = "mp3_church_bell"
            enviromentUrls[4] = "mp3_construction"
            enviromentUrls[5] = "mp3_thunderstorm_long"
            enviromentUrls[6] = "mp3_traffic"
        }
        
        return enviroment
    }
    
    func getListTime() -> [String] {
        if times.count == 0 {
            times.append(L10n.Timer.tenSeconds)
            times.append(L10n.Timer.thirtySeconds)
            times.append(L10n.Timer.aMinute)
            times.append(L10n.Timer.fiveMinutes)
            times.append(L10n.Timer.tenMinutes)
        }
        
        return times
    }
    
    func getListWallpaper() -> [String] {
        if wallpaper.count == 0 {
            wallpaper.append("Wallpaper 1")
            wallpaper.append("Wallpaper 2")
        }
        return wallpaper
    }
}
