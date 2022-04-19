//
//  WaitViewController.swift
//  FakeCall
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

class WaitViewController: UIViewController {
    static let TAG = "WaitViewController"
    
    var timer:Timer?
    var timeLeft = 2
    
    var viewModel: WaitingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        
        // keep screen alway on
        UIApplication.shared.isIdleTimerDisabled = true
        
        timeLeft = viewModel?.settingObject?.timerValue ?? 10
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        if viewModel?.settingObject?.isCancelable ?? false {
            let tap = UITapGestureRecognizer(target:self, action: #selector(tripleTapped))
            tap.numberOfTapsRequired = 3
            view.addGestureRecognizer(tap)
        }
        
    }
    
    @objc func tripleTapped() {
        showToast(message: "Canceled call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            exit(-1)
        })
    }
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1

        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            let nextScreen = CallingViewController()
            nextScreen.settingObject = viewModel?.settingObject
            navigationController?.pushViewController(nextScreen, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        // disale keep screen alway on
        UIApplication.shared.isIdleTimerDisabled = false
    }

}
