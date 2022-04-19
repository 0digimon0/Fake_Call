//
//  ContactInfoCellTableViewCell.swift
//  Fake Call Funy
//
//  Created by admin on 3/5/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit
import ContactsUI

class ContactInfoCellTableViewCell: UITableViewCell, UITextFieldDelegate {
    public static let identifier = "ContactInfoCellTableViewCell"
    
    private let contactPicker = CNContactPickerViewController()
    var parentController: UIViewController?
    var listener: CallerInformationSetting?
    
    let inputName: UITextField = {
        let input = UITextField()
        input.font = UIFont.systemFont(ofSize: 15)
        input.placeholder = L10n.Contact.callerName
        input.backgroundColor = UIColor(hex: "f0f0f0")
        //input.layer.borderWidth = 1.0;
        input.layer.cornerRadius = 8.0;
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 40))
        input.leftViewMode = UITextField.ViewMode.always
        return input
    }()
    
    let inputPhoneNumber: UITextField = {
        let input = UITextField()
        input.font = UIFont.systemFont(ofSize: 15)
        input.keyboardType = .numberPad
        input.placeholder = L10n.Contact.callerNumber
        input.backgroundColor = UIColor(hex: "f0f0f0")
//        input.layer.borderWidth = 1.0;
        input.layer.cornerRadius = 8.0;
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 40))
        input.leftViewMode = UITextField.ViewMode.always
        return input
    }()
    
    let labelCaution: UILabel = {
        let caution = UILabel()
        caution.font = UIFont.italicSystemFont(ofSize: 13)
        caution.textColor = UIColor(named: ColorName.settingSelected)
        caution.text = L10n.Contact.caution
        return caution
    }()
    
    let avatarSelector: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(asset: Asset.icContact), for: .normal)
        return btn
    }()
    
    let contactSelector: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(asset: Asset.icSelectContact), for: .normal)
        return btn
    }()
    
    let mImagePicker: UIButton = {
        let btn = UIButton()
        btn.setTitle("Avatar", for: .normal)
        return btn
    }()
    
    let mClearData: UIButton = {
        let btn = UIButton()
        btn.setTitle("Clear", for: .normal)
        return btn
    }()
    
    let contactAvatar:UIImageView = {
        let imgv = UIImageView()
        imgv.clipsToBounds = true
        return imgv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        inputName.resignFirstResponder()
        inputPhoneNumber.resignFirstResponder()
        return true
    }
    
    func initViews() {
        backgroundColor = UIColor.white
        
        self.addSubview(contactAvatar)
        contactAvatar.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.bottom.left.equalToSuperview()
            $0.height.equalTo(180)
        }
        contactAvatar.contentMode = .scaleAspectFill
        contactAvatar.isHidden = true
        contactAvatar.clipsToBounds = true
        
        self.addSubview(contactSelector)
        contactSelector.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(60)
        }
        contactSelector.addTarget(self, action: #selector(openContactSelector), for: .touchUpInside)
        
        self.addSubview(inputName)
        inputName.snp.makeConstraints{
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contactSelector.snp.leading).offset(-10)
            $0.height.equalTo(35)
        }
        inputName.delegate = self
        inputName.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        
        self.addSubview(inputPhoneNumber)
        inputPhoneNumber.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.equalTo(contactSelector.snp.leading).inset(-10)
            $0.top.equalTo(inputName.snp.bottom).offset(15)
            $0.height.equalTo(35)
        }
        inputPhoneNumber.delegate = self
        inputPhoneNumber.addTarget(self, action: #selector(textDidChanged(_:)), for: UIControl.Event.editingChanged)
        inputPhoneNumber.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
        
        self.addSubview(mClearData)
        mClearData.snp.makeConstraints{
            $0.top.equalTo(inputPhoneNumber.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(30)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        mClearData.backgroundColor = UIColor.cyan
        mClearData.isHidden = true
        
        self.addSubview(mImagePicker)
        mImagePicker.snp.makeConstraints{
            $0.top.equalTo(inputPhoneNumber.snp.bottom).offset(15)
            $0.right.equalToSuperview().offset(-30)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
        mImagePicker.backgroundColor = UIColor.cyan
        mImagePicker.isHidden = true
        
        self.addSubview(labelCaution)
        labelCaution.snp.makeConstraints{
//            $0.top.equalTo(mClearData.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        print("Done");
        inputPhoneNumber.resignFirstResponder()
    }
    
    @objc func textDidChanged(_ textField: UITextField) {
        guard let str = inputName.text, let num = inputPhoneNumber.text else {
            (parentController as! HomeViewController).enableStartButton(isEnable: false)
            listener?.onInformationChanged(name: "", data: nil)
            return
        }
        
        if str.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 || num.count > 0 {
            (parentController as! HomeViewController).enableStartButton(isEnable: true)
            listener?.onInformationChanged(name: str, data: nil)
            return
        }
        
        // disable done button on home
        (parentController as! HomeViewController).enableStartButton(isEnable: false)
    }
    
    @objc func openContactSelector() {
        contactPicker.delegate = self
        self.parentController?.present(contactPicker, animated: true, completion: nil)
    }
}

//extension UITextField {
//    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
//        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
//        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
//
//        let toolbar: UIToolbar = UIToolbar()
//        toolbar.barStyle = .default
//        toolbar.items = [
//            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
//            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
//            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
//        ]
//        toolbar.sizeToFit()
//
//        self.inputAccessoryView = toolbar
//    }
//
//    // Default actions:
//    @objc func doneButtonTapped() { self.resignFirstResponder() }
//    @objc func cancelButtonTapped() { self.resignFirstResponder() }
//}

extension ContactInfoCellTableViewCell: CNContactPickerDelegate {

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let phoneNumberCount = contact.phoneNumbers.count

        guard phoneNumberCount > 0 else {
            parentController?.dismiss(animated: true)
            return
        }

        if phoneNumberCount == 1 {
            setContact(contact: contact)
        } else {
            let alertController = UIAlertController(title: "Select one of the numbers", message: nil, preferredStyle: .alert)

            for i in 0...phoneNumberCount-1 {
                let phoneAction = UIAlertAction(title: contact.phoneNumbers[i].value.stringValue, style: .default, handler: {
                alert -> Void in
                    self.setContact(contact: contact)
                })
                alertController.addAction(phoneAction)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            alert -> Void in

            })
            alertController.addAction(cancelAction)

            parentController?.dismiss(animated: true)
            self.parentController?.present(alertController, animated: true, completion: nil)
        }
    }

    func setContact(contact: CNContact) {
        let contactNumber = contact.phoneNumbers[0].value.stringValue
        self.inputPhoneNumber.text = contactNumber
        self.inputName.text = contact.givenName + " " + contact.familyName
        let name = contact.givenName + " " + contact.familyName
        listener?.onInformationChanged(name: name, data: nil)
        (parentController as! HomeViewController).enableStartButton(isEnable: true)
        
        if contact.imageDataAvailable {
            DataCallSetting.sharedData.settingObject.avatarData = contact.imageData
            contactAvatar.isHidden = false
            contactAvatar.image = UIImage(data: contact.imageData!)
        } else {
            contactAvatar.isHidden = true
        }
        
        guard contactNumber.count >= 10 else {
            parentController?.dismiss(animated: true) {
                //self.popUpMessageError(value: 10, message: "Selected contact does not have a valid number")
            }
            return
        }

    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
}
