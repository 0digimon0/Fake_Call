//
//  TutorialPageController.swift
//  FakeCall
//
//  Created by admin on 7/3/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class TutorialPageController: UIViewController {
    
    lazy var tutorialPage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(asset: Asset.tutorial1)
        return img
    }()
    
    var pageIndex:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tutorialPage)
        tutorialPage.snp.makeConstraints{
            $0.top.leading.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
        
        var image:UIImage
        switch pageIndex {
        case 1:
            image = UIImage(asset: Asset.tutorial1)
        case 2:
            image = UIImage(asset: Asset.tutorial2)
        case 3:
            image = UIImage(asset: Asset.tutorial3)
        case 4:
            image = UIImage(asset: Asset.tutorial4)
        case 5:
            image = UIImage(asset: Asset.tutorial5)
        case 6:
            image = UIImage(asset: Asset.tutorial6)
        case 7:
            image = UIImage(asset: Asset.tutorial7)
        case 8:
            image = UIImage(asset: Asset.tutorial8)
        default:
            image = UIImage(asset: Asset.tutorial1)
        }
        
        tutorialPage.image = image
        tutorialPage.contentMode = .scaleAspectFit
        
        // Do any additional setup after loading the view.
    }
}
