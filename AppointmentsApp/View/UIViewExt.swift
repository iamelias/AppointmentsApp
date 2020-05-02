//
//  UIViewExt.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.


import Foundation
import UIKit

extension UIView {
    
    func set(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }
}
