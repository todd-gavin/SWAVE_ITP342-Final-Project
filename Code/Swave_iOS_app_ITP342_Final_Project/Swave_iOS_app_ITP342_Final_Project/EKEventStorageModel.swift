//
//  EKEventStorageModel.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/6/22.
//

import UIKit
import EventKit

class EKEventStorageModel: NSObject {
    
    // Define a variable named "EKEventStorage" that will store a 2D array of strings
    var EKEventStorage: [[String]] = []

    // Define a shared instance of the EKEventStorageModel
    static let sharedInstance = EKEventStorageModel()

    // Override the parent class' initializer
    override init() {
        super.init()
    }

    // Define a function that returns the number of events stored in EKEventStorage
    func numberOfEVents() -> Int {
        return EKEventStorage.count
    }

    // Define a function that gets the event title at a given index in EKEventStorage
    func getEventTitle(at index: Int) -> String {
        // If the given index is within the bounds of EKEventStorage, return the first element of the subarray at that index
        if(index >= 0 && index < EKEventStorage.count) {
            return EKEventStorage[index][0]
        }
        // If the given index is out of bounds, return "nil string"
        else {
            return "nil string"
        }
    }

    // Define a function that gets the event details at a given index in EKEventStorage
    func getEventDetails(at index: Int) -> String {
        // If the given index is within the bounds of EKEventStorage, return the second element of the subarray at that index
        if(index >= 0 && index < EKEventStorage.count) {
            return EKEventStorage[index][1]
        }
        // If the given index is out of bounds, return "nil string"
        else {
            return "nil string"
        }
    }

    // Define a function that adds an event to EKEventStorage
    func addEventToStorage(event: [String]) {
        // Append the given event (which is a two-element array) to EKEventStorage
        EKEventStorage.append([event[0], event[1]])
    }


}

