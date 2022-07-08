//
//  Common functions.swift
//  Blog
//
//  Created by MacBook Air 13 Retina 2018 on 04.07.2022.
//  Copyright © 2022 MacBook Air 13 Retina 2018. All rights reserved.
//

import Foundation
import UIKit

func errorAC(_ message:String) -> UIAlertController
{
    let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    return ac
}

func setupLabel(label:UILabel,text:String,color:UIColor,scrollView:UIScrollView) {
    label.text = text
    label.textColor = color
    label.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(label)
}

func setupTextField(textField:UITextField,tag:Int,size:CGFloat) {
    textField.tag = tag
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.font = .systemFont(ofSize: size)
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.keyboardType = UIKeyboardType.default
    textField.returnKeyType = UIReturnKeyType.done
    textField.clearButtonMode = UITextField.ViewMode.whileEditing
    textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    textField.textContentType = .oneTimeCode // this line solves error iCloud Keychain is disabled
}
