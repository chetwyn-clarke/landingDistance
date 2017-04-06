//
//  AircraftListVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit
import CoreData

class AircraftListVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<Aircraft>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generateTestData()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AircraftCell", for: indexPath) as! AircraftCell
        let aircraft = controller.object(at: indexPath as IndexPath)
        cell.configureCell(aircraft: aircraft)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TO DO: Edit this function properly.
        
        if let fetchedObjs = controller.fetchedObjects, fetchedObjs.count > 0 {
            let aircraft = fetchedObjs[indexPath.row]
            performSegue(withIdentifier: "toConfigurationListVC", sender: aircraft)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ConfigurationListVC {
            if let aircraft = sender as? Aircraft {
                destination.selectedAircraft = aircraft
            }
            
        }
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Aircraft> = Aircraft.fetchRequest()
        let typeSort = NSSortDescriptor(key: "type", ascending: true)
        let engineSort = NSSortDescriptor(key: "engine", ascending: true)
        fetchRequest.sortDescriptors = [typeSort, engineSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
    }
    
    func generateTestData() {
        
        let aircraft1 = Aircraft(context: context)
        aircraft1.type = "737-700W"
        aircraft1.engine = "CFM56-7B22 (22K)"
        
        let aircraft2 = Aircraft(context: context)
        //Put the extra spaces after the W to make the aircraft type unique for sorting purposes.  Need to find a better way.
        aircraft2.type = "737-700W  "
        aircraft2.engine = "CFM56-7B24 (24K)"
        
        let aircraft3 = Aircraft(context: context)
        aircraft3.type = "737-800W"
        aircraft3.engine = "CFM56-7B26 (26K)"
        
        let aircraft4 = Aircraft(context: context)
        aircraft4.type = "737-800W SFP"
        aircraft4.engine = "CFM56-7B26 (26K)"
        
        //TO DO: Need to add notes to configurations, before including ad.saveContext
        
        // Aircraft 1
        
        let configuration11 = Configuration(context: context)
        configuration11.name = "Flaps 15"
        configuration11.type = "Normal"
        configuration11.flapSetting = ""
        configuration11.aircraft = aircraft1
        
        let configuration12 = Configuration(context: context)
        configuration12.name = "Flaps 30"
        configuration12.type = "Normal"
        configuration12.flapSetting = ""
        configuration12.aircraft = aircraft1
        
        let configuration13 = Configuration(context: context)
        configuration13.name = "All Flaps Up Landing"
        configuration13.type = "Non-Normal"
        configuration13.flapSetting = ""
        configuration13.aircraft = aircraft1
        
        let configuration14 = Configuration(context: context)
        configuration14.name = "Leading Edge Flaps Transit"
        configuration14.type = "Non-Normal"
        configuration14.flapSetting = "Flaps 15"
        configuration14.aircraft = aircraft1
        
        // Aircraft 2
        
        let configuration21 = Configuration(context: context)
        configuration21.name = "Flaps 30"
        configuration21.type = "Normal"
        configuration21.flapSetting = ""
        configuration21.aircraft = aircraft2
        
        let configuration22 = Configuration(context: context)
        configuration22.name = "Flaps 40"
        configuration22.type = "Normal"
        configuration22.flapSetting = ""
        configuration22.aircraft = aircraft2
        
        let configuration23 = Configuration(context: context)
        configuration23.name = "Antiskid Inoperative"
        configuration23.type = "Non-Normal"
        configuration23.flapSetting = "Flaps 15"
        configuration23.aircraft = aircraft2
        
        let configuration24 = Configuration(context: context)
        configuration24.name = "Manual Reversion"
        configuration24.type = "Non-Normal"
        configuration24.flapSetting = "Flaps 15"
        configuration24.aircraft = aircraft2
        
        // Aircraft 3
        
        let configuration31 = Configuration(context: context)
        configuration31.name = "Flaps 15"
        configuration31.type = "Normal"
        configuration31.flapSetting = ""
        configuration31.aircraft = aircraft3
        
        let configuration32 = Configuration(context: context)
        configuration32.name = "Flaps 40"
        configuration32.type = "Normal"
        configuration32.flapSetting = ""
        configuration32.aircraft = aircraft3
        
        let configuration33 = Configuration(context: context)
        configuration33.name = "Loss of System A"
        configuration33.type = "Non-Normal"
        configuration33.flapSetting = "Flaps 30"
        configuration33.aircraft = aircraft3
        
        let configuration34 = Configuration(context: context)
        configuration34.name = "Loss of System B"
        configuration34.type = "Non-Normal"
        configuration34.flapSetting = "Flaps 15"
        configuration34.aircraft = aircraft3
        
        // Aircraft 4
        
        let configuration41 = Configuration(context: context)
        configuration41.name = "Flaps 40"
        configuration41.type = "Normal"
        configuration41.flapSetting = ""
        configuration41.aircraft = aircraft4
        
        let configuration42 = Configuration(context: context)
        configuration42.name = "Flaps 15"
        configuration42.type = "Normal"
        configuration42.flapSetting = ""
        configuration42.aircraft = aircraft4
        
        let configuration43 = Configuration(context: context)
        configuration43.name = "Speedbrake Do Not Arm"
        configuration43.type = "Non-Normal"
        configuration43.flapSetting = "Flaps 15"
        configuration43.aircraft = aircraft4
        
        let configuration44 = Configuration(context: context)
        configuration44.name = "One Engine Inoperative Landing"
        configuration44.type = "Non-Normal"
        configuration44.flapSetting = "Flaps 15"
        configuration44.aircraft = aircraft4
        
        ad.saveContext()
    
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
