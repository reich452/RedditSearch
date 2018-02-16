//
//  SearchPostTableViewController.swift
//  RedditSwift4Skills
//
//  Created by Nick Reichard on 2/15/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class SearchPostTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        return cell
    }
    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
