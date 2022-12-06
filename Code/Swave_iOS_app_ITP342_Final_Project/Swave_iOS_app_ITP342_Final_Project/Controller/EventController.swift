//
//  EventController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/5/22.
//

import UIKit
import EventKit

class EventController: UIViewController {
    
    @IBOutlet weak var titleOutlet: UITextField!
    @IBOutlet weak var dayOutlet: UISegmentedControl!
    @IBOutlet weak var timeOfDayOutlet: UISegmentedControl!
    @IBOutlet weak var eventLengthOutlet: UISegmentedControl!
    @IBOutlet weak var notesOutlet: UITextField!

    let eventStore = EKEventStore()
    
    private var userModel = UserModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function) Event Controller Page")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClickedAction(_ sender: UIBarButtonItem) {
        print("\(#function)")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createCalendarEventClickedAction(_ sender: UIButton) {
        print("\(#function)")
        
        if (titleOutlet.text!.isEmpty || notesOutlet.text!.isEmpty) {
            
            let alert = UIAlertController(title: "", message: "Please fill in all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            requestCalendarAccess()
//            let events = readCalendarEvents()
//            printCalendarEvents(events: events)
        }
        
    }
    
    func getEventInfo() -> [String] {
        print("\(#function)")
        let title = titleOutlet.text!
        
        let lat = String(userModel.getLocationLat())
        let long = String(userModel.getLocationLong())
        let location = "\(lat), \(long)"
        
        let notes = notesOutlet.text!
        
        return [title, location, notes]
    }
    
    func getEventDates() -> [Date] {
        print("\(#function)")
        
        let day = dayOutlet.selectedSegmentIndex
        let time = timeOfDayOutlet.selectedSegmentIndex
        let length = eventLengthOutlet.selectedSegmentIndex
        
        let currentDate = Date()
        print("**************\nCurrent Date: \(currentDate)")
        // Create a Calendar instance
        let calendar = Calendar.current
        // Use the Calendar to create a new Date object with the time components set to midnight
        let dateOnly = calendar.startOfDay(for: currentDate)
        print("dateOnly: \(dateOnly)")
        
        // 1. Set Day
        // Create a DateComponents object representing two days
        let days = DateComponents(day: day)
        // Create new date set to midnight
        let date1 = calendar.date(byAdding: days, to: dateOnly)
        print("date1: \(String(describing: date1))")
        
        // 2. Set Start Time
        let timeArray = [8, 13, 18]
        let timeComponents = DateComponents(timeZone: TimeZone(identifier: "PST"), hour: timeArray[time], minute: 0)
        // Use the Calendar to create a new Date object using the dateOnly and timeComponents objects
        let dateWithStartTime = calendar.date(byAdding: timeComponents, to: date1!)
        print("dateWithStartTime: \(String(describing: dateWithStartTime))")
        
        // 3. Set End Time
        let lengthArray = [1, 3, 5]
        let hours = DateComponents(hour: lengthArray[length])
        // Use the Calendar to add the threeHours object to the currentDate to create a new Date object
        let dateWithEndTime = calendar.date(byAdding: hours, to: dateWithStartTime!)
        print("dateWithEndTime: \(String(describing: dateWithEndTime))\n**********")
        
        print("Start DateTime: \(String(describing: dateWithStartTime))\nEnd DateTime: \(String(describing: dateWithEndTime))")
        
        return [dateWithStartTime!, dateWithEndTime!]
        
    }
    
    func requestCalendarAccess() {
        print("\(#function)")
        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                // User has granted permission to access their calendar
                print("User DID grant permission to access their calendar: \(granted)")
                
                DispatchQueue.main.async {
                    let startEndDateTimes = self.getEventDates()
                    let start = startEndDateTimes[0]
                    let end = startEndDateTimes[1]
                    let eventInfo = self.getEventInfo()
                    self.createCalendarEvent(eventInfo: eventInfo, startDate: start, endDate: end)
//                    let events = self.readCalendarEvents()
//                    print("**** Events: \(events)")
//                    self.printCalendarEvents(events: events)
                }
                
            } else {
                // User has denied permission to access their calendar
                print("User DID NOT grant permission to access their calendar: \(String(describing: error))")
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        // Create a DateFormatter instance
        let formatter = DateFormatter()

        // Set the date format to "EEEE, MMMM d, yyyy h:mm a"
        formatter.dateFormat = "EEEE, MMMM d, yyyy h:mm a"

        // Set the time zone to Pacific Standard Time
        formatter.timeZone = TimeZone(identifier: "PST")

        // Use the DateFormatter to convert the date to a string
        let dateString = formatter.string(from: date)

        return dateString
    }

    func createCalendarEvent(eventInfo: [String], startDate: Date, endDate: Date) {
        print("\(#function)")
        let newEvent = EKEvent(eventStore: eventStore)
        newEvent.title = eventInfo[0]
        newEvent.startDate = startDate
        newEvent.endDate = endDate
        newEvent.location = eventInfo[1]
        newEvent.notes = eventInfo[2]
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        print("\n\n******Event Title: \(String(describing: eventInfo[0]))")
        print("Start Date: \(String(describing: startDate))")
        print("End Date: \(String(describing: endDate))")
        print("Location: \(String(describing: eventInfo[1]))")
        print("Notes: \(String(describing:eventInfo[2]))")
        print("Calendar: \(String(describing:newEvent.calendar))")

        do {
            try eventStore.save(newEvent, span: .thisEvent)
            print("Event WAS created and saved.")
            
            let start = dateToString(date: startDate)
            let end = dateToString(date: endDate)
            
            let alert = UIAlertController(title: "A new surf event was placed on your calendar.", message: "Title: \(eventInfo[0])\n Start: \(start)\nEnd: \(end)\nLocation: \(eventInfo[1])\nNotes: \(eventInfo[2])", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } catch {
            // Handle error
            print("Event WAS NOT created and saved.")
        }
    }

//    func readCalendarEvents() -> [EKEvent] {
//        print("\(#function)")
//        let calendars = eventStore.calendars(for: .event)
//        let startDate = Date()
//        let endDate = Date() + 86400 // 24 hours
//        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
//
//        return eventStore.events(matching: predicate)
//    }
//
//    func printCalendarEvents(events: [EKEvent]) {
//        print("\(#function)")
//        for event in events {
//            print("\n\nEvent Title: \(String(describing: event.title))")
//            print("Start Date: \(String(describing: event.startDate))")
//            print("End Date: \(String(describing: event.endDate))")
//            print("Location: \(String(describing: event.location))")
//            print("Notes: \(String(describing: event.notes))")
//        }
//
//    }

    func updateCalendarEvent(event: EKEvent) {
        print("\(#function)")
        event.title = "Updated Meeting with John"
        event.startDate = Date() + 3600 // 1 hour from now
        event.endDate = Date() + 7200 // 2 hours duration

        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            // Handle error
        }
    }

    func deleteCalendarEvent(event: EKEvent) {
        print("\(#function)")
        do {
            try eventStore.remove(event, span: .thisEvent)
        } catch {
            // Handle error
        }
    }

}