//
//  EKEventStorageModel.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/6/22.
//

import UIKit
import EventKit



class EKEventStorageModel: NSObject {

    var EKEventStorage: [[String]] = []
    
//    var eventTitle: String
//    var eventDetails: String
    
    static let sharedInstance = EKEventStorageModel()
    
    override init() {
        super.init()
    }
    
    func numberOfEVents() -> Int {
        return EKEventStorage.count
    }
    
//    func getEvent(at index: Int) -> EKEvent? {
//        if(index >= 0 && index < EKEventStorage.count) {
//            return EKEventStorage[index]
//        } else {
//            return nil
//        }
//    }
    
    func getEventTitle(at index: Int) -> String {
        if(index >= 0 && index < EKEventStorage.count) {
            return EKEventStorage[index][0]
        } else {
            return "nil string"
        }
    }
    
    func getEventDetails(at index: Int) -> String {
        if(index >= 0 && index < EKEventStorage.count) {
            return EKEventStorage[index][1]
        } else {
            return "nil string"
        }
    }
    
    func addEventToStorage(event: [String]) {
        EKEventStorage.append([event[0], event[1]])
    }

}
