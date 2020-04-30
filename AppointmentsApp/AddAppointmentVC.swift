//
//  AddAppointmentVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation
import UIKit

struct Appointment {
    var name: String?
    var date: Date?
}

enum Messages: String {
    case Add
    case PickerLabel = "Date & Time"
    case Appointment
}

protocol AddAppointmentDelegate {
    func addAppointment(appointment: Appointment)
}

class AddAppointmentVC: UIViewController {

    let textField = UITextField()
    let picker = UIDatePicker()
    let addButton = UIButton()
    let pickerLabel = UILabel()
    let message = UITextView()
    
    var getAppointment: AddAppointmentDelegate!

    override func viewDidLoad() {
        
        textField.delegate = self

        title = "Add Appointment"
        view.backgroundColor = .white //background color is default clear, which would look black and be laggy
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButtonView()
        textFieldView()
        pickerLabelView()
        pickerView()
        
        let tapped = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tapped.cancelsTouchesInView = false
        view.addGestureRecognizer(tapped)
        
        //messageView()


        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backTapped))
    }
    
    @objc func addButtonTapped() {
        
        var newAppointment = Appointment()
        newAppointment.date = picker.date
        newAppointment.name = textField.text

        getAppointment.addAppointment(appointment: newAppointment)
        self.navigationController?.popViewController(animated: true) //removing VC from NavStack Stack
    }
    
   //MARK: VIEWS
    
    func createMessage() {
        message.text = "Enter name and select date"
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
    
    func messageView() {
        message.textColor = .black
        message.textAlignment = .center
        view.addSubview(message)
        addMessageConstraints()
        
    }
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
    
    func addMessageConstraints() {
        message.translatesAutoresizingMaskIntoConstraints = false
        message.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        message.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        message.heightAnchor.constraint(equalToConstant: 50).isActive = true
        message.centerYAnchor.constraint(equalTo: textField.topAnchor, constant: 50).isActive = true
        
    }
}

extension AddAppointmentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

