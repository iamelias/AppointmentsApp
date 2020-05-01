//
//  ViewConstraints.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/30/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation

extension AddAppointmentVC {
    //MARK: CONSTRAINTS
    func addButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func addTextFieldConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.centerYAnchor.constraint(equalTo: addButton.topAnchor, constant: -40).isActive = true
    }
    
    func addPickerLabelConstraints() {
        pickerLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        pickerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        pickerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pickerLabel.centerYAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 50).isActive = true
    }
    
    func addPickerConstraints() {
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        picker.centerYAnchor.constraint(equalTo: pickerLabel.bottomAnchor, constant: 5).isActive = true
    }
}
