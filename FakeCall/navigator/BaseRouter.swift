//
//  BaseRouter.swift
//  FakeCall
//
//  Created by admin on 3/15/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRouter {
    func route(to screen: UIViewController,
               from context: UIViewController)
}
