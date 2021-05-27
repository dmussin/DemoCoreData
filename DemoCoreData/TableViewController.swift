//
//  TableViewController.swift
//  DemoCoreData
//
//  Created by Daniyar Mussin on 27.05.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks: [Task ] = []
    
    @IBAction func saveTask(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert) // creating alertController
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in // creating an SAVE action
            let textField = alertController.textFields?.first // getting textField
            if let newTaskTitle = textField?.text { // checking
                self.saveTask(withTitle: newTaskTitle) // adding a record to array
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

    private func saveTask(withTitle title: String) { // method for saving into CoreData
        
        let contex = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: contex) else { return } // getting to entity
        
        let taskObject = Task(entity: entity, insertInto: contex) // getting task object
        taskObject.title = title
        
        // saving context
        do {
            try contex.save()
            tasks.append(taskObject) // adding to Task array
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext { //getting viewContext from AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let contex = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()   // request to get the all objects from entity task
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false) // correcting fetchrequest
        fetchRequest.sortDescriptors = [sortDescriptor] // setting sortDescriptor to fetch
        
        // getting objects
        do {
            tasks = try contex.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DELETING 
//        let contex = getContext()
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        if let results = try? contex.fetch(fetchRequest) {
//            for object in results {
//                contex.delete(object)
//            }
//        }
//
//        do {
//            try contex.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
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

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        

        return cell
    }
    


}
