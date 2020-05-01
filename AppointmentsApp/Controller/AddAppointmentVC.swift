//
//  AddAppointmentVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation
import UIKit

//struct Appointment {
//    var name: String?
//    var date: Date?
//    var appointmentId: String?
//}

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
        
        let tapped = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) //dismissing keyboard when view is tapped
        tapped.cancelsTouchesInView = false
        view.addGestureRecognizer(tapped)

    }
    
    @objc func addButtonTapped() {
        
        var newAppointment = Appointment() //reflects Core Data attributes
        newAppointment.date = picker.date
        newAppointment.name = textField.text
        newAppointment.appointmentId = UUID().uuidString

        getAppointment.addAppointment(appointment: newAppointment)
        
        
        self.navigationController?.popViewController(animated: true) //removing VC from NavStack Stack
    }
    
   //MARK: VIEWS
    
    func createMessage() {
        message.text = "Enter name and select date"
    }
        
 

}

extension AddAppointmentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //dismissing keyboard when done key is tapped
    }
}

