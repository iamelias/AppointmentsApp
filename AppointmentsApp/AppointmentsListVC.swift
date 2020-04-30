//
//  AppointmentsListVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import UIKit

class AppointmentsListVC: UIViewController {
    
    var appointments: [Appointment] = []
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Appointments"
        configureTableView()
        tableView.rowHeight = 200
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
        tableView.reloadData()
    }
    
    @objc func backTapped() {

    }
    
    @objc func addTapped() {
        
        let addVC = AddAppointmentVC()
        navigationController?.pushViewController(addVC, animated: true) //presents push
        addVC.getAppointment = self
        
//        present(addVC, animated: true, completion: nil) //presents modally
    }
    
    func reformatDate(index: Int) -> String? {
        let cell: String?
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "en_US")
        
        cell = "\(dateFormatter.string(from: appointments[index].date ?? Date()))"
        
        return cell
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
       // return appointments.count
        return appointments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AppointmentCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    
        if appointments[indexPath.row].name == "" {
            appointments[indexPath.row].name = "No name"
        }
        
        cell.textLabel?.text = appointments[indexPath.row].name
        
        cell.detailTextLabel?.text = reformatDate(index: indexPath.row) ?? "Error"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //unhighlights row after auto highlight on selection
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        appointments.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension AppointmentsListVC: AddAppointmentDelegate {
    func addAppointment(appointment: Appointment) {
                
        appointments.append(appointment)
    }
    
    
}
