//
//  SelectionRouter.swift
//  FakeCall
//
//  Created by admin on 5/24/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: BaseRouter {
    func routeToRingtoneSelection(viewModel: SelectionViewModel, from: UIViewController) {
        let controller = RingtoneSettingViewController()
        controller.viewModel = viewModel
        route(to: controller, from: from)
    }
    
    func routeToRingtoneSelection(viewModel: SelectionViewModel, from: UIViewController, callback: OptionSelected) {
        let controller = RingtoneSettingViewController()
        controller.listener = callback
        controller.viewModel = viewModel
        route(to: controller, from: from)
    }
    
    func routeToSelection(viewModel: SelectionViewModel, from: UIViewController) {
        let controller = SettingSelectionViewController()
        controller.viewModel = viewModel
        route(to: controller, from: from)
    }
    
    func routeToSelection(viewModel: SelectionViewModel, from: UIViewController, callback: OptionSelected) {
        let controller = SettingSelectionViewController()
        controller.listener = callback
        controller.viewModel = viewModel
        route(to: controller, from: from)
    }
    
    func routeToWaitingScreen(viewModel: WaitingViewModel, from context: UIViewController) {
        let nextScreen = WaitViewController()
        nextScreen.viewModel = viewModel
        route(to: nextScreen, from: context)
    }
    
    func routeToCallerScreen(viewModel: ContactInforViewModel, from context: UIViewController, callback: CallerInformationSetting) {
        let nextScreen = CallerInformationViewController()
        nextScreen.listener = callback
        nextScreen.contactViewModel = viewModel
        route(to: nextScreen, from: context)
    }
    
    func routeToWallpaperScreen(viewModel: WallpaperViewModel, from context: UIViewController, callback: OptionSelected) {
        let nextScreen = WallpaperSelectController()
        nextScreen.listener = callback
        nextScreen.viewModel = viewModel
        route(to: nextScreen, from: context)
    }
    
    func route(to screen: UIViewController, from context: UIViewController) {
        context.navigationController?.pushViewController(screen, animated: true)
    }
}
