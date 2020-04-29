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
        title = "My Appointments"
        configureTableView()
        tableView.rowHeight = 200
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    }
    
    @objc func backTapped() {

    }
    
    @objc func addTapped() {
        
        let addVC = AddAppointmentVC()
        navigationController?.pushViewController(addVC, animated: true)
//        present(addVC, animated: true, completion: nil)
        
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
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AppointmentCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "en_US")

        cell.textLabel?.text = appointments[indexPath.row]
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: Date()))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelect indexPath: IndexPath) {
        
    }
}
