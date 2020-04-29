//
//  AddAppointmentVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation
import UIKit


class AddAppointmentVC: UIViewController {
    // Title of Appointment TextField
    // Date Picker for appointment time
    // Turn on Notification Reminder
    
    
    override func viewDidLoad() {
        title = "Add Appointment"
        view.backgroundColor = .white //background color is default clear, which would look black and be laggy
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backTapped))
    }
    
    @objc func backTapped() {
        
    }
    
}
