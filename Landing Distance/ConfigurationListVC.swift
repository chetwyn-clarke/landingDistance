//
//  ConfigurationListVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/5/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit
import CoreData

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
    
    func generateTestNumbers() {
        
        let advisoryData331 = AdvisoryData(context: context)
        advisoryData331.brakeAction = "Good to Medium"
        advisoryData331.brakeConfiguration = "Max Manual"
        advisoryData331.refWeight = 145000
        advisoryData331.refDistance = 6510
        advisoryData331.weightAdjAbvRef = 340
        advisoryData331.weightAdjBlwRef = -350
        advisoryData331.altAdjStd = 180
        advisoryData331.altAdjHigh = 250
        advisoryData331.windAdjHeadwind = -280
        advisoryData331.windAdjTailwind = 980
        advisoryData331.slopeAdjUp = 260
        advisoryData331.slopeAdjDown = -210
        advisoryData331.tempAdjAbvISA = 160
        advisoryData331.tempAdjBlwISA = -160
        advisoryData331.refSpeed = "VREF30"
        advisoryData331.appSpeedAdj = 260
        advisoryData331.revThrustAdjOneRev = 690
        advisoryData331.revThrustAdjNoRev = 1560
        advisoryData331.aircraft = aircraft3
        advisoryData331.configuration = configuration33
        
        let advisoryData332 = AdvisoryData(context: context)
        advisoryData332.brakeAction = "Dry"
        advisoryData332.brakeConfiguration = "Autobrake Max"
        advisoryData332.refWeight = 145000
        advisoryData332.refDistance = 6520
        advisoryData332.weightAdjAbvRef = 340
        advisoryData332.weightAdjBlwRef = -360
        advisoryData332.altAdjStd = 180
        advisoryData332.altAdjHigh = 250
        advisoryData332.windAdjHeadwind = -280
        advisoryData332.windAdjTailwind = 980
        advisoryData332.slopeAdjUp = 250
        advisoryData332.slopeAdjDown = -200
        advisoryData332.tempAdjAbvISA = 160
        advisoryData332.tempAdjBlwISA = -160
        advisoryData332.refSpeed = "VREF30"
        advisoryData332.appSpeedAdj = 270
        advisoryData332.revThrustAdjOneRev = 690
        advisoryData332.revThrustAdjNoRev = 1560
        advisoryData332.aircraft = aircraft3
        advisoryData332.configuration = configuration33
        
        let advisoryData333 = AdvisoryData(context: context)
        advisoryData333.brakeAction = "Dry"
        advisoryData333.brakeConfiguration = "Autobrake 2"
        advisoryData333.refWeight = 145000
        advisoryData333.refDistance = 8120
        advisoryData333.weightAdjAbvRef = 420
        advisoryData333.weightAdjBlwRef = -470
        advisoryData333.altAdjStd = 220
        advisoryData333.altAdjHigh = 290
        advisoryData333.windAdjHeadwind = -360
        advisoryData333.windAdjTailwind = 1230
        advisoryData333.slopeAdjUp = 100
        advisoryData333.slopeAdjDown = -80
        advisoryData333.tempAdjAbvISA = 220
        advisoryData333.tempAdjBlwISA = -230
        advisoryData333.refSpeed = "VREF30"
        advisoryData333.appSpeedAdj = 430
        advisoryData333.revThrustAdjOneRev = 170
        advisoryData333.revThrustAdjNoRev = 770
        advisoryData333.aircraft = aircraft3
        advisoryData333.configuration = configuration33
        
        let advisoryData341 = AdvisoryData(context: context)
        advisoryData341.brakeAction = "Dry"
        advisoryData341.brakeConfiguration = "Max Manual"
        advisoryData341.refWeight = 145000
        advisoryData341.refDistance = 4270
        advisoryData341.weightAdjAbvRef = 170
        advisoryData341.weightAdjBlwRef = -180
        advisoryData341.altAdjStd = 90
        advisoryData341.altAdjHigh = 120
        advisoryData341.windAdjHeadwind = -140
        advisoryData341.windAdjTailwind = 480
        advisoryData341.slopeAdjUp = 60
        advisoryData341.slopeAdjDown = -50
        advisoryData341.tempAdjAbvISA = 90
        advisoryData341.tempAdjBlwISA = -90
        advisoryData341.refSpeed = "VREF15"
        advisoryData341.appSpeedAdj = 140
        advisoryData341.revThrustAdjOneRev = 130
        advisoryData341.revThrustAdjNoRev = 130
        advisoryData341.aircraft = aircraft3
        advisoryData341.configuration = configuration34
        
        
        //ad.saveContext()
        
        
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
