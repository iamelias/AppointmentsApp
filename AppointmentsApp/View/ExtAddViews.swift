//
//  ExtAddViews.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/30/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation
import UIKit
extension AddAppointmentVC {
    
    func mainView() {
        title = "Add Appointment"
        view.backgroundColor = .white //background color is default clear, which would look black and be laggy
    }
    
    func addButtonView() {
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.black, for: .normal)
        addButton.setTitle(Messages.Add.rawValue, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 7))
        addButton.layer.cornerRadius = 20
        addButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor //popping shadow
        addButton.layer.shadowOffset = CGSize(width: 0, height: 3) //shadow underneath
        addButton.layer.shadowOpacity = 1.0 //1.0 is most opaque shadow, 0 . transparent
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.layer.shadowRadius = 10.0
        addButton.layer.borderWidth = 1.0
        addButton.layer.masksToBounds = false
        
        view.addSubview(addButton)
        addButtonConstraints()
    }
    
    func textFieldView() {
        textField.placeholder = Messages.Appointment.rawValue
        textField.backgroundColor = .white
        textField.borderStyle = .line
        textField.textColor = .blue
        view.addSubview(textField)
        addTextFieldConstraints()
    }
    
    func pickerLabelView() {
        pickerLabel.text = Messages.PickerLabel.rawValue
        pickerLabel.textAlignment = .center
        pickerLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(pickerLabel)
        addPickerLabelConstraints()
    }
    
    func pickerView() {
        picker.datePickerMode = .dateAndTime
        
        view.addSubview(picker)
        addPickerConstraints()
    }
    
    func imageView() {
        
        let convertedImage = UIImage(named: "Star") //image stored in assets
        image = UIImageView(image: convertedImage)
        
        view.addSubview(image!)
        view.addSubview(image!)
        addImageConstraints()
    }
}
