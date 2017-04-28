//
//  ResultsVC.swift
//  Landing Distance
//
//  Created by Chetwyn on 4/28/17.
//  Copyright © 2017 Clarke Enterprises. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

//MARK: - Table View Implementation

extension ResultsVC: UITableViewDelegate, UITableViewDataSource {
    
    //TODO: Set tableView Requirements.  Need height and results array.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as! ResultsCell
        //TODO: Create a Results array to use to configure the cell.
        //cell.configureCell(result: <#T##Result#>)
        return cell
    }
    
    
    
}
