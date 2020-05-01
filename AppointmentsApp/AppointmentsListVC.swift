//
//  AppointmentsListVC.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class AppointmentsListVC: UIViewController {
    
    var appointments: [Appointment] = []
    var coreAppointments: [CoreAppointments] = []
    let context = DatabaseController.persistentStoreContainer().viewContext

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Appointments"
        configureTableView() //setup tableview
        tableView.rowHeight = 200
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        fetchData() //fetching persisted data
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear called")
        tableView.reloadData()
    }

    func fetchData() { //fetching persisted data from Core Data, storing data in coreAppointments arrray
        let fetchRequest: NSFetchRequest<CoreAppointments> = CoreAppointments.fetchRequest()
//               let sortDescriptor = NSSortDescriptor(key: "date", ascending: true) //last dish is latest dated dish
//               fetchRequest.sortDescriptors = [sortDescriptor] //last element is most recent date
               
        do {
            coreAppointments = try context.fetch(fetchRequest) //getting all saved dishes and setting equal to dishes
        }
        catch {
            print("Unable to fetch")
        }
    }
    
    @objc func addTapped() { // add button is tapped push to AddAppointment VC to get appointment
        
        let addVC = AddAppointmentVC()
        navigationController?.pushViewController(addVC, animated: true) //presents push
        addVC.getAppointment = self
        
//        present(addVC, animated: true, completion: nil) //presents modally
    }
    
    func reformatDate(index: Int) -> String? { //changing the date format for the tableview detail text
        let cell: String?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        cell = "\(dateFormatter.string(from: coreAppointments[index].date ?? Date()))"
        return cell
    }
    
    func addCoreAppointment(appointment: Appointment) { //Persisting appointment data
        let coreApp = CoreAppointments(context: context)
        coreApp.name = appointment.name
        coreApp.date = appointment.date
        coreApp.appointmentId = UUID().uuidString
        coreAppointments.append(coreApp)
        DatabaseController.saveContext()
        //appointments.append(appointment)
    }
    
    func deleteCoreAppointment(appointment: CoreAppointments) { //Deletes specific appointment from Core Data
        context.delete(appointment)
        DatabaseController.saveContext()
    }
    
    func configureTableView() { //Adding tableView
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.set(to: view)
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "Cell")
    }
}

//MARK: TABLE VIEW
extension AppointmentsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AppointmentCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    
        if coreAppointments[indexPath.row].name == "" {
            coreAppointments[indexPath.row].name = "No name"
        }
        
        cell.textLabel?.text = coreAppointments[indexPath.row].name
        
        cell.detailTextLabel?.text = reformatDate(index: indexPath.row) ?? "Error"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //unhighlights row after auto highlight on selection
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if let identifier = coreAppointments[indexPath.row].appointmentId { //deleting notification from center
            let nCenter = UNUserNotificationCenter.current()
            nCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        }
        
        deleteCoreAppointment(appointment: coreAppointments[indexPath.row]) //removing from core data
        coreAppointments.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

//MARK: ADDAPPOINTMENTDELEGATE
extension AppointmentsListVC: AddAppointmentDelegate {
    func addAppointment(appointment: Appointment) {
        addCoreAppointment(appointment: appointment)
        setupNotification(appointment: appointment)
    }
    
    func setupNotification(appointment: Appointment) {
          
          let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: appointment.date!) //needed for message
    
          let notificationMessage = "Remember \(appointment.name!) is at: \(timeComponents.hour!):\(timeComponents.minute!) today "//message that will be on notification"
          let content = UNMutableNotificationContent()
          content.body = notificationMessage
          content.sound = UNNotificationSound.default
          
          //Notification will appear on device at 7:30 on chosen day
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: appointment.date!)
          dateComponents.hour = 20
          dateComponents.minute = 24
        
        //making notification trigger
          let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
          
          if let identifier = appointment.appointmentId {
              let request = UNNotificationRequest(identifier: identifier, content: content, trigger:  trigger)
              let nCenter = UNUserNotificationCenter.current()
              nCenter.add(request, withCompletionHandler: nil)
          }
     }
}
