// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Caution
  internal static let caution = L10n.tr("Localizable", "caution")
  /// Discard
  internal static let discard = L10n.tr("Localizable", "discard")
  /// Done
  internal static let done = L10n.tr("Localizable", "done")
  /// None
  internal static let `none` = L10n.tr("Localizable", "none")
  /// Save
  internal static let save = L10n.tr("Localizable", "save")
  /// Start
  internal static let start = L10n.tr("Localizable", "start")
  /// Start now
  internal static let startNow = L10n.tr("Localizable", "start_now")

  internal enum CallerVoice {
    /// Child
    internal static let child = L10n.tr("Localizable", "callerVoice.child")
    /// Man
    internal static let man = L10n.tr("Localizable", "callerVoice.man")
    /// Caller voice
    internal static let name = L10n.tr("Localizable", "callerVoice.name")
    /// Women
    internal static let women = L10n.tr("Localizable", "callerVoice.women")
  }

  internal enum Calling {
    /// Accecpt
    internal static let accept = L10n.tr("Localizable", "calling.accept")
    /// add call
    internal static let addCall = L10n.tr("Localizable", "calling.add_call")
    /// audio
    internal static let audio = L10n.tr("Localizable", "calling.audio")
    /// contacts
    internal static let contacts = L10n.tr("Localizable", "calling.contacts")
    /// Decline
    internal static let decline = L10n.tr("Localizable", "calling.decline")
    /// FaceTime
    internal static let facetime = L10n.tr("Localizable", "calling.facetime")
    /// keypad
    internal static let keypad = L10n.tr("Localizable", "calling.keypad")
    /// Message
    internal static let message = L10n.tr("Localizable", "calling.message")
    /// mute
    internal static let mute = L10n.tr("Localizable", "calling.mute")
    /// Remind Me
    internal static let remindMe = L10n.tr("Localizable", "calling.remind_me")
  }

  internal enum Contact {
    /// Caller name
    internal static let callerName = L10n.tr("Localizable", "contact.caller_name")
    /// Caller number
    internal static let callerNumber = L10n.tr("Localizable", "contact.caller_number")
    /// *You just need input to one of name or number of caller.
    internal static let caution = L10n.tr("Localizable", "contact.caution")
    /// Please setting caller to start
    internal static let caution2 = L10n.tr("Localizable", "contact.caution2")
  }

  internal enum Discard {
    /// Do you want discard all setting
    internal static let caution = L10n.tr("Localizable", "discard.caution")
  }

  internal enum Enviroment {
    /// Beach
    internal static let beach = L10n.tr("Localizable", "enviroment.beach")
    /// Church
    internal static let church = L10n.tr("Localizable", "enviroment.church")
    /// Contruction
    internal static let contruction = L10n.tr("Localizable", "enviroment.contruction")
    /// Farm Ville
    internal static let farmville = L10n.tr("Localizable", "enviroment.farmville")
    /// Enviroment
    internal static let name = L10n.tr("Localizable", "enviroment.name")
    /// Rain
    internal static let rain = L10n.tr("Localizable", "enviroment.rain")
    /// Street
    internal static let street = L10n.tr("Localizable", "enviroment.street")
  }

  internal enum Header {
    /// Advance settings
    internal static let advanceSettings = L10n.tr("Localizable", "header.advance_settings")
    /// Basic settings
    internal static let basicSettings = L10n.tr("Localizable", "header.basic_settings")
    /// Caller information
    internal static let callerInformation = L10n.tr("Localizable", "header.caller_information")
    /// More settings
    internal static let moreSettings = L10n.tr("Localizable", "header.more_settings")
  }

  internal enum Home {
    /// Advance setting
    internal static let advanceSettingDes = L10n.tr("Localizable", "home.advance_setting_des")
    /// Contact information
    internal static let contactDescription = L10n.tr("Localizable", "home.contact_description")
    /// Contact name
    internal static let nameInputHint = L10n.tr("Localizable", "home.name_input_hint")
    /// Phone number
    internal static let nnumberInputHint = L10n.tr("Localizable", "home.nnumber_input_hint")
  }

  internal enum Menu {
    /// New call
    internal static let newCall = L10n.tr("Localizable", "menu.new_call")
    /// Quick call
    internal static let quickCall = L10n.tr("Localizable", "menu.quick_call")
    /// Tutorial
    internal static let tutorial = L10n.tr("Localizable", "menu.tutorial")
  }

  internal enum Ringtone {
    /// Default (Iphone Original)
    internal static let `default` = L10n.tr("Localizable", "ringtone.default")
    /// Fast and sad
    internal static let fastAndSad = L10n.tr("Localizable", "ringtone.fast_and_sad")
    /// MI
    internal static let mi = L10n.tr("Localizable", "ringtone.mi")
    /// Ringtone
    internal static let name = L10n.tr("Localizable", "ringtone.name")
    /// Samsung S20
    internal static let samsung = L10n.tr("Localizable", "ringtone.samsung")
    /// Silent
    internal static let silent = L10n.tr("Localizable", "ringtone.silent")
    /// Sound and Vibration
    internal static let soundVibration = L10n.tr("Localizable", "ringtone.sound_vibration")
    /// Tiktok
    internal static let tik = L10n.tr("Localizable", "ringtone.tik")
    /// Only vibration
    internal static let vibration = L10n.tr("Localizable", "ringtone.vibration")
  }

  internal enum Setting {
    /// Please do not turn off scrren by press power button, just keep screen on or flip screen off!
    internal static let pleaseDoNotTurnOffScreen = L10n.tr("Localizable", "setting.please_do_not_turn_off_screen")
    /// Triple tap on waiting screen to cancel fake call
    internal static let tripleTapToCancel = L10n.tr("Localizable", "setting.triple_tap_to_cancel")
  }

  internal enum Timer {
    /// 1 minute
    internal static let aMinute = L10n.tr("Localizable", "timer.a_minute")
    /// 5 minutes
    internal static let fiveMinutes = L10n.tr("Localizable", "timer.five_minutes")
    /// Start after
    internal static let startAfter = L10n.tr("Localizable", "timer.start_after")
    /// 10 minutes
    internal static let tenMinutes = L10n.tr("Localizable", "timer.ten_minutes")
    /// 10 seconds
    internal static let tenSeconds = L10n.tr("Localizable", "timer.ten_seconds")
    /// 30 seconds
    internal static let thirtySeconds = L10n.tr("Localizable", "timer.thirty_seconds")
  }

  internal enum Wallpaper {
    /// Wallpaper
    internal static let name = L10n.tr("Localizable", "wallpaper.name")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
