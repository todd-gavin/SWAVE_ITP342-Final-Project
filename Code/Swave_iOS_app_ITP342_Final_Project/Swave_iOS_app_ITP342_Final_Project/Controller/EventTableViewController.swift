//
//  EventTableViewController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/6/22.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    private var userModel = UserModel.sharedInstance
    private var eventModel = EKEventStorageModel.sharedInstance
    
    @IBOutlet var tableViewOutlet: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        tableView.isEditing = false
        // Need to add more to this method
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    // Checks for memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Ensures that there is only one section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    // Allows user to move a flashcard based on its index in the tableView
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to finalIndexPath: IndexPath) {
//        cardModel.rearrageFlashcards(from: fromIndexPath.row, to: finalIndexPath.row)
//    }
    
    // Sets the number of rows in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModel.numberOfEVents()
    }

    // Fills the cell with data (question and answer) from the flashcards array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        print("title: \(String(describing: eventModel.getEventTitle(at: indexPath.row)))")
        print("notes: \(String(describing: eventModel.getEventDetails(at: indexPath.row)))")

        cell.textLabel?.text = eventModel.getEventTitle(at: indexPath.row)
//        cell.detailTextLabel?.text = eventModel.getEventDetails(at: indexPath.row)
        return cell
    }
    
//    // Turns on editing for the tableView cells
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    // Allows a flashcard to be deleted from the tableView and ensure that a new file is saved on the simulator
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            cardModel.removeFlashcard(at: indexPath.row)
//            cardModel.save()
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
}
