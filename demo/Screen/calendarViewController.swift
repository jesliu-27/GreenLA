//
//  calendarViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/23/21.
//

import UIKit
import EventKit

class calendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission(startDate: Date(), evenName: "Recycle")

        // Do any additional setup after loading the view.
    }
    
    
    func checkPermission(startDate:Date, evenName:String){
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event){
            
        case .notDetermined:
            eventStore.requestAccess(to: .event) { status, error in
                if status{
                    
                }
                else{
                    print(error?.localizedDescription)
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            print("denial")
        case .authorized:
            self.insertEvent(Store: eventStore, startDate: startDate, evenName: evenName)
        @unknown default:
            print("Unknow:")
        }
    }
    
    
    
    func insertEvent(Store:EKEventStore, startDate: Date, evenName: String){
        let calendars = Store.calendars(for: .event)
        for calendar in calendars{
            if calendar.title == "Calendar"{
                let event = EKEvent(eventStore: Store)
                event.calendar = calendar
                event.startDate = startDate
                event.title = evenName
                event.endDate = event.startDate.addingTimeInterval(60)
                event.recurrenceRules = [EKRecurrenceRule(recurrenceWith: .daily, interval: 1, end: nil)]
                let reminder1 = EKAlarm(relativeOffset: -60)
                let reminder2 = EKAlarm(relativeOffset: -300)
                event.alarms = [reminder1,reminder2]
                do{
                    try Store.save(event, span: .thisEvent)
        
                }
                catch{
                    
                }
                

            }
        }
    }

}
