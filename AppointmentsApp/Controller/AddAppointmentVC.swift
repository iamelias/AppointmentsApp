//
//  AddAppointmentVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation
import UIKit

protocol AddAppointmentDelegate {
    func addAppointment(appointment: Appointment)
}

class AddAppointmentVC: UIViewController {
    
    let textField = UITextField()
    let picker = UIDatePicker()
    let addButton = UIButton()
    let pickerLabel = UILabel()
    var image: UIImageView?
    
    var getAppointment: AddAppointmentDelegate!
    
    override func viewDidLoad() {
        
        textField.delegate = self
        
        mainView()
        addButtonView()
        textFieldView()
        pickerLabelView()
        pickerView()
        imageView()
        checkOrientation()
        setUpTapGesture()
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        
        var newAppointment = Appointment() //reflects Core Data attributes
        newAppointment.date = picker.date
        newAppointment.name = textField.text
        newAppointment.appointmentId = UUID().uuidString
        
        getAppointment.addAppointment(appointment: newAppointment)
        
        self.navigationController?.popViewController(animated: true) //removing VC from NavStack Stack
    }
    
    func setUpTapGesture() {
        let tapped = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) //dismissing keyboard when view is tapped
        tapped.cancelsTouchesInView = false
        view.addGestureRecognizer(tapped)
        
    }
    
    func checkOrientation() { //deciding whether to show image...dependins on orientation
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            image!.isHidden = true
        }
        else {
            image!.isHidden = false
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) { //if orientation changes
        coordinator.animate(alongsideTransition: { context in
            self.checkOrientation()
        })
    }
}

extension AddAppointmentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //dismissing keyboard when done key is tapped
    }
}

