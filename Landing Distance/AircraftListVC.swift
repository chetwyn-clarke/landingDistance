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
        //deleteAircraft()
        //deleteConfigurations()
        //deleteAdvisoryInformation()
        //deleteAllInfo()
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
        
        let splitViewController = self.splitViewController
        
        let detailNavController = splitViewController?.viewControllers.last as? UINavigationController
        
        if let destination = segue.destination as? ConfigurationListVC {
            
            if let aircraft = sender as? Aircraft {
                destination.selectedAircraft = aircraft
            }
            
            if let enterConditionsVC = detailNavController?.topViewController as? EnterConditionsVC {
                destination.advisoryDelegate = enterConditionsVC
                print("Delegate set")
            } else {
                print("Delegate not set")
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
        
        // Configuratons for Aircraft 1
        
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
        
        // Configurations for Aircraft 2
        
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
        
        // Configurations for Aircraft 3
        
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
        configuration33.notes = "Reference distance is based on sea level, standard day, no wind or slope, and maximum available reverse thrust.\n\nMAX MANUAL assumes maximum achievable manual braking.\n\nReference Distance includes an air distance allowance of 1500 ft. from threshold to touchdown.\n\nActual (unfactored) distances are shown."
        
        let configuration34 = Configuration(context: context)
        configuration34.name = "Loss of System B"
        configuration34.type = "Non-Normal"
        configuration34.flapSetting = "Flaps 15"
        configuration34.aircraft = aircraft3
        configuration34.notes = "Reference distance is based on sea level, standard day, no wind or slope, and maximum available reverse thrust.\n\nMAX MANUAL assumes maximum achievable manual braking.\n\nReference Distance includes an air distance allowance of 1500 ft. from threshold to touchdown.\n\nActual (unfactored) distances are shown."
        
        // Configurations for Aircraft 4
        
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
        
        // Advisory Data for Configuration33
        
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
        
        // Advisory Data for Configuration34
        
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
        
        print("Test data generated")
        
        ad.saveContext()
    
    }
    
    func deleteAircraft() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Aircraft")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            ad.saveContext()
            print("Aircraft deleted")
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func deleteConfigurations() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Configuration")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            ad.saveContext()
            print("Configurations deleted")
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func deleteAdvisoryInformation() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AdvisoryData")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            ad.saveContext()
            print("Advisory Data deleted")
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func deleteAllInfo() {
        deleteAircraft()
        deleteConfigurations()
        deleteAdvisoryInformation()
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

}
