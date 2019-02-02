//
//  ToDoTableViewController.swift
//  scheduleManagement
//
//  Created by Kien on 2/1/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    var resultsController:NSFetchedResultsController<Todo>!
    let coreData =  CoreDataStack()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request:NSFetchRequest<Todo> = Todo.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptors]
        resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreData.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            
            try resultsController.performFetch()
        }catch{
            
            print("Perform fetch erro:\(error)")
        }
        
     
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return resultsController.sections[]
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsController.sections?[section].numberOfObjects ?? 0

       
    }
    
    //Mark- Tableview delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action  = UIContextualAction(style: .destructive, title: "Delete"){ (action,view,completion) in
            
            completion(true)
        }
        action.image = UIImage(named: "trash-2")
        
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let todo =  resultsController.object(at: indexPath)
        cell.textLabel?.text = todo.title
//        cell.
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let  _ =  sender as? UIBarButtonItem, let vc = segue.destination as? AddToDoViewController {
            vc.managerContext  = coreData.managedContext
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action  = UIContextualAction(style: .destructive, title: "Delete"){ (action,view,completion) in
            
            completion(true)
        }
        action.image = UIImage(named:  "check")
        
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
      
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
