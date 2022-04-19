//
//  HomeRouter.swift
//  FakeCall
//
//  Created by admin on 3/15/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation
import UIKit


class MenuRounter: BaseRouter {
    
    func routeToHomeScreen(viewModel: HomeViewModel, from context: UIViewController) {
        let nextScreen = HomeViewController()
        nextScreen.homeViewModel = viewModel
        route(to: nextScreen, from: context)
    }
    
    func routeToWaitingScreen(viewModel: WaitingViewModel, from context: UIViewController) {
        let nextScreen = WaitViewController()
        nextScreen.viewModel = viewModel
        route(to: nextScreen, from: context)
    }
    
    func route(to screen: UIViewController, from context: UIViewController) {
        context.navigationController?.pushViewController(screen, animated: true)
    }

}
