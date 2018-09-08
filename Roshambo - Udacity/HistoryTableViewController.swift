//
//  HistoryTableViewController.swift
//  Roshambo - Udacity
//
//  Created by Vigneshraj Sekar Babu on 9/8/18.
//  Copyright © 2018 Vigneshraj Sekar Babu. All rights reserved.
//

import UIKit

var history: [MatchResults] = []

class HistoryTableViewController: UITableViewController {
    let cellReuseIdentifier = "historyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let index = history.count - (indexPath.row + 1)
        let row = history[index]
    
        cell.textLabel?.text = row.result
        cell.detailTextLabel?.text = row.detail
        
        
        return cell
    }


}
