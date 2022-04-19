//
//  MenuViewController.swift
//  FakeCall
//
//  Created by admin on 5/27/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController, ItemSettingSelected {

    var rounte:MenuRounter?
    
    lazy var mBanner:UIImageView = {
        let imgv = UIImageView()
        imgv.image = UIImage(asset: Asset.menuBanner)
        return imgv
    }()
    
    lazy var mNewSetting:UIButton = {
        let btn = UIButton()
        btn.titleEdgeInsets = UIEdgeInsets(top: 0,left: 26,bottom: 0,right: 0)
        btn.setTitle(L10n.Menu.newCall, for: .normal)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    lazy var mTutorial:UIButton = {
        let btn = UIButton()
        btn.titleEdgeInsets = UIEdgeInsets(top: 0,left: 26,bottom: 0,right: 0)
        btn.setTitle(L10n.Menu.tutorial, for: .normal)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    lazy var mQuickCallLb:UILabel = {
        let lb = UILabel()
        lb.text = (L10n.Menu.quickCall).capitalized
        lb.applyFontWithColorAndSize(color: MyColors.HeaderTextColor, sized: 17)
        lb.textColor = MyColors.HeaderTextColor
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    func setupViews() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
//        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 2000)
        
        scrollView.addSubview(mBanner)
        mBanner.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalToSuperview()
        }
        mBanner.contentMode = .scaleAspectFit
        
//        let appIcon = UIImageView(image: UIImage(asset: Asset.iconApp1))
//        mBanner.addSubview(appIcon)
//        appIcon.snp.makeConstraints{
//            $0.top.left.equalToSuperview()
//            $0.width.height.equalTo(100)
//        }
        
        scrollView.addSubview(mNewSetting)
        mNewSetting.snp.makeConstraints{
            $0.top.equalTo(mBanner.snp.bottom).offset(20)
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        }
        mNewSetting.backgroundColor = UIColor.darkGray
        mNewSetting.addTarget(self, action: #selector(openNewSetting), for: .touchUpInside)
        
        scrollView.addSubview(mQuickCallLb)
        mQuickCallLb.snp.makeConstraints{
            $0.top.equalTo(mNewSetting.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(30)
        }
        
        var pivot:UIView = mQuickCallLb
        var index:Int = 0
        for setting in DataCallSetting.getQuickSettings() {
            let btn1 = QuickCallView(object: setting)
            btn1.index = index
            scrollView.addSubview(btn1)
            btn1.snp.makeConstraints{
                $0.top.equalTo(pivot.snp.bottom).offset(10)
                $0.left.equalToSuperview()
                $0.width.equalToSuperview()
            }
            btn1.listener = self
            pivot = btn1
            index += 1
        }
        
        scrollView.addSubview(mTutorial)
        mTutorial.snp.makeConstraints{
            $0.top.equalTo(pivot.snp.bottom).offset(25)
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-30)
        }
        mTutorial.backgroundColor = UIColor.darkGray
//        mTutorial.isHidden = true
        mTutorial.addTarget(self, action: #selector(openTutorial), for: .touchUpInside)
        
    }
    
    func onItemSelected(index: Int) {
        let viewModel = WaitingViewModel(object: DataCallSetting.getQuickSettings()[index])
        rounte = MenuRounter()
        rounte?.routeToWaitingScreen(viewModel: viewModel, from: self)
    }

    @objc func openNewSetting() {
        rounte = MenuRounter()
        rounte?.routeToHomeScreen(viewModel: HomeViewModel(), from: self)
    }
    
    @objc func openTutorial() {
        self.navigationController?.pushViewController(TutorialViewController(), animated: true)
    }
}
