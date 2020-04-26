//
//  AppointmentsListVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import UIKit

class AppointmentsListVC: UIViewController {
    
    var appointments: [String] = ["Apple", "Orange", "Pear", "Banana", "Grape", "Kiwi"]
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.set(to: view)
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "Cell")
    }
}


extension AppointmentsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AppointmentCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")


        cell.textLabel?.text = appointments[indexPath.row]
        cell.detailTextLabel?.text = "\(Date())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
