//
//  ResultsVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/28/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notes: UILabel!
    
    var results: [Result]!
    var selectedConfiguration: Configuration!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateUI()
    }
    
    func updateUI() {
        
        if let configNotes = selectedConfiguration.notes {
            notes.text = configNotes
        }
        
        tableView.reloadData()
        
        print(results.count)
        
    }
    
    //MARK: - Table View Implementation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        let result = results[indexPath.row]
        cell.configureCell(result: result)
        return cell
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



