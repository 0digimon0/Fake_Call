//
//  RadioGroupView.swift
//  FakeCall
//
//  Created by admin on 3/18/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit

enum RadioGroupType {
    case Default    // only radio
    case Horizontal //with title
    case Vertical   //with title
}

class RadioGroupView: UIView {

    var onItemSelected:((_ id: Int) -> Void)?
    
    var groupType: RadioGroupType = RadioGroupType.Default
    
    var displayWidth: Float = 0
    var displayHeight: Float = 0
    var selectedPosition = 0
    
    var listButton:[RadioButtonView] = []
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        displayWidth = Float(frame.width)
        displayHeight = Float(frame.height)
        initViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initViews() {
        addSubview(stackView)
        stackView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self)
            make.width.equalToSuperview()
        }
        updateViews()
    }
    
    func addItem(button: RadioButtonView) {
        listButton.append(button)
        updateViews()
    }
    
    func updateViews() {
        for i in 0 ..< listButton.count  {
            stackView.addArrangedSubview(listButton[i])
            listButton[i].snp.makeConstraints{(make) -> Void in
                make.width.equalTo(displayWidth*0.3)
                make.height.equalTo(displayHeight)
            }
            listButton[i].onChecked = { [unowned self] in
                self.selectedPosition = i
                self.updateItemsState()
                self.onItemSelected?(i)
            }
        }
        updateItemsState()
    }
    
    func setSelected(index: Int) {
        selectedPosition = index
        updateItemsState()
    }
    
    func updateItemsState() {
        for i in 0 ..< listButton.count  {
            if i == selectedPosition {
                listButton[i].setCheck(isCheck: true)
            } else {
                listButton[i].setCheck(isCheck: false)
            }
        }
    }
}
