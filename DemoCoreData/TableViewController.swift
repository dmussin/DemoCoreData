//
//  TableViewController.swift
//  DemoCoreData
//
//  Created by Daniyar Mussin on 27.05.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tasks: [String] = []
    
    @IBAction func saveTask(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert) // creating alertController
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in // creating an SAVE action
            let textField = alertController.textFields?.first // getting textField
            if let newTask = textField?.text { // checking
                self.tasks.insert(newTask, at: 0) // adding a record to array
                self.tableView.reloadData() // showing in table via reload
            }
        }
         
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }// creating an CANCEL action
 
        // adding actions
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
 
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row]
        

        return cell
    }
    


}
