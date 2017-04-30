//
//  ConfigurationListVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit
import CoreData

// To send advisoryData object to EnterDetailsVC we have to set up a delegate here and implement it in the receivingVC.

protocol ConfigurationSentDelegate: NSObjectProtocol {
    
    func userDidSelectConfiguration(configuration: Configuration)
}

class ConfigurationListVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var _selectedAircraft: Aircraft!
    
    var selectedAircraft: Aircraft {
        get {
            return _selectedAircraft
        } set {
            _selectedAircraft = newValue
        }
    }
    
    var controller: NSFetchedResultsController<Configuration>!
    
    weak var configurationDelegate: ConfigurationSentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetch()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            
            //Capitalise the results for the section
            return sectionInfo.name.uppercased()
        }
        
        return ""
    }
    
    // Next function sets the style for the headerView /  section titles
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Avenir", size: 14)
        header.textLabel?.textColor = UIColor.lightGray
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigurationCell", for: indexPath) as! ConfigurationCell
        let configuration = controller.object(at: indexPath as IndexPath)
        cell.configureCell(configuration: configuration)
        return cell
    }
    
    // Configure height of rows, and section headers.
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedConfiguration = controller.object(at: indexPath as IndexPath)
        
        configurationDelegate?.userDidSelectConfiguration(configuration: selectedConfiguration)
        
        if let selectedAdvisorySet = selectedConfiguration.advisoryData {
            print("selectedAdvisorySetCount is \(selectedAdvisorySet.count).")
        }
        
        print("Set sent to protocol function.")
        
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Configuration> = Configuration.fetchRequest()
        let typeSort = NSSortDescriptor(key: "type", ascending: false)
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        //Use the engine for the predicate since the engines are unique, whereas the types are not.  Can't do that, because some carry the same engine.
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["aircraft.type", selectedAircraft.type!])
        fetchRequest.sortDescriptors = [typeSort, nameSort]
        fetchRequest.predicate = predicate
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "type", cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
