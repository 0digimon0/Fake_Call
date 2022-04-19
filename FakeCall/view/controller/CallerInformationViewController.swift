//
//  CallerInformationViewController.swift
//  FakeCall
//
//  Created by admin on 6/16/20.
//  Copyright © 2020 com.tah. All rights reserved.
//

import UIKit
import SnapKit
import ContactsUI

class CallerInformationViewController: UIViewController, UITextFieldDelegate {
    
    private let contactPicker = CNContactPickerViewController()
    var listener: CallerInformationSetting?
    var buttonSave: UIBarButtonItem!
    var contactViewModel: ContactInforViewModel?
    var imageData:Data?
    
    let inputName: UITextField = {
        let input = UITextField()
        input.font = UIFont.systemFont(ofSize: 16)
        input.placeholder = L10n.Contact.callerName
        input.backgroundColor = UIColor(hex: "f0f0f0")
        //input.layer.borderWidth = 1.0;
        input.layer.cornerRadius = 8.0;
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 40))
        input.leftViewMode = UITextField.ViewMode.always
        return input
    }()
    
    let labelCaution: UITextView = {
        let caution = UITextView()
        caution.font = UIFont.italicSystemFont(ofSize: 13)
        caution.textColor = UIColor(named: ColorName.settingSelected)
        caution.text = L10n.Contact.caution
        caution.sizeToFit()
        caution.isEditable = false
        return caution
    }()
    
    let avatarSelector: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    let contactSelector: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(asset: Asset.icSelectContact), for: .normal)
        return btn
    }()
    
    let contactAvatar:UIImageView = {
        let imgv = UIImageView()
        imgv.clipsToBounds = true
        return imgv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSave = UIBarButtonItem(title: L10n.save, style: .plain, target: self, action: #selector(onSaveData))
        self.navigationItem.rightBarButtonItem  = buttonSave
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        initViews()
    }
    
    @objc func onSaveData() {
        listener?.onInformationChanged(name: inputName.text ?? "", data: imageData)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        inputName.resignFirstResponder()
        return true
    }
    
    func initViews() {
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(avatarSelector)
        avatarSelector.snp.makeConstraints{
            $0.width.height.equalTo(120)
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(contactSelector)
        contactSelector.snp.makeConstraints{
            $0.top.equalTo(avatarSelector.snp.bottom).offset(40)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(60)
        }
        contactSelector.addTarget(self, action: #selector(openContactSelector), for: .touchUpInside)
        
        self.view.addSubview(inputName)
        inputName.snp.makeConstraints{
            $0.centerY.equalTo(contactSelector.snp.centerY)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(contactSelector.snp.leading).offset(-10)
            $0.height.equalTo(45)
        }
        inputName.delegate = self
        inputName.addTarget(self, action: #selector(textDidChanged(_:)), for: .editingChanged)
        inputName.text = contactViewModel?.contactName
        
        self.view.addSubview(labelCaution)
        labelCaution.snp.makeConstraints{
            $0.top.equalTo(contactSelector.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        setImageData(image: contactViewModel?.contactImage)
    }
    
    @objc func textDidChanged(_ textField: UITextField) {
        guard let str = inputName.text else {
//            listener?.onInformationChanged(name: "", data: imageData)
            return
        }
        
        if str.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            buttonSave.isEnabled = true
            return
        }

        buttonSave.isEnabled = false
    }
    
    @objc func openContactSelector() {
        contactPicker.delegate = self
        present(contactPicker, animated: true, completion: nil)
    }
    
    func setImageData(image: Data?) {
        if let data = image {
            avatarSelector.setImage(UIImage(data: data), for: .normal)
            avatarSelector.clipsToBounds = true
            avatarSelector.layer.cornerRadius = 60
            avatarSelector.layer.borderWidth = 2
            avatarSelector.layer.borderColor = UIColor.black.cgColor
            avatarSelector.contentMode = .scaleAspectFit
        } else {
            avatarSelector.setImage(UIImage(asset: Asset.icContact), for: .normal)
            avatarSelector.clipsToBounds = false
            avatarSelector.layer.cornerRadius = 0
            avatarSelector.layer.borderWidth = 0
            avatarSelector.contentMode = .scaleAspectFit
        }
        
    }
    
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: L10n.cancel, style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: L10n.done, style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}

extension CallerInformationViewController: CNContactPickerDelegate {
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let phoneNumberCount = contact.phoneNumbers.count
        
        guard phoneNumberCount > 0 else {
            dismiss(animated: true)
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
            let cancelAction = UIAlertAction(title: L10n.cancel, style: .destructive, handler: {
                alert -> Void in
                
            })
            alertController.addAction(cancelAction)
            
            dismiss(animated: true)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func setContact(contact: CNContact) {
        let contactNumber = contact.phoneNumbers[0].value.stringValue
        self.inputName.text = contact.givenName + " " + contact.familyName
        
        buttonSave.isEnabled = true
        
        if contact.imageDataAvailable {
            imageData = contact.imageData
            setImageData(image: contact.imageData)
            
        } else {
            imageData = nil
            setImageData(image: nil)
        }
        
        guard contactNumber.count >= 10 else {
            dismiss(animated: true) {
                //self.popUpMessageError(value: 10, message: "Selected contact does not have a valid number")
            }
            return
        }
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
    }
}

