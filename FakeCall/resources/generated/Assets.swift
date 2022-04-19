// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let icAccept = ImageAsset(name: "ic_accept")
  internal static let icAdd = ImageAsset(name: "ic_add")
  internal static let icAlarmClockWhite = ImageAsset(name: "ic_alarm_clock_white")
  internal static let icContact = ImageAsset(name: "ic_contact")
  internal static let icContact1 = ImageAsset(name: "ic_contact_1")
  internal static let icDecline = ImageAsset(name: "ic_decline")
  internal static let icFaceTime = ImageAsset(name: "ic_faceTime")
  internal static let icKeypad = ImageAsset(name: "ic_keypad")
  internal static let icMessageWhite = ImageAsset(name: "ic_message_white")
  internal static let icMute = ImageAsset(name: "ic_mute")
  internal static let icOpen = ImageAsset(name: "ic_open")
  internal static let icPause = ImageAsset(name: "ic_pause")
  internal static let icPlay = ImageAsset(name: "ic_play")
  internal static let icRadioButtonOff = ImageAsset(name: "ic_radio_button_off")
  internal static let icRadioButtonOn = ImageAsset(name: "ic_radio_button_on")
  internal static let icSelectContact = ImageAsset(name: "ic_select_contact")
  internal static let icSpeaker = ImageAsset(name: "ic_speaker")
  internal static let icTicked = ImageAsset(name: "ic_ticked")
  internal static let iconApp1 = ImageAsset(name: "icon_app_1")
  internal static let iconCaller = ImageAsset(name: "icon_caller")
  internal static let iconContact = ImageAsset(name: "icon_contact")
  internal static let iconEnviroment = ImageAsset(name: "icon_enviroment")
  internal static let iconRingtone = ImageAsset(name: "icon_ringtone")
  internal static let iconTime = ImageAsset(name: "icon_time")
  internal static let iconWallpaper = ImageAsset(name: "icon_wallpaper")
  internal static let menuBanner = ImageAsset(name: "menu_banner")
  internal static let tutorial1 = ImageAsset(name: "tutorial_1")
  internal static let tutorial2 = ImageAsset(name: "tutorial_2")
  internal static let tutorial3 = ImageAsset(name: "tutorial_3")
  internal static let tutorial4 = ImageAsset(name: "tutorial_4")
  internal static let tutorial5 = ImageAsset(name: "tutorial_5")
  internal static let tutorial6 = ImageAsset(name: "tutorial_6")
  internal static let tutorial7 = ImageAsset(name: "tutorial_7")
  internal static let tutorial8 = ImageAsset(name: "tutorial_8")
  internal static let wallpaper1 = ImageAsset(name: "wallpaper_1")
  internal static let wallpaper2 = ImageAsset(name: "wallpaper_2")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
