//
//  RatingsSelectionTableViewController.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 14/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit


class RatingsSelectionTableViewController: UITableViewController {
    
    private let ratings = [0,1,2,3,4,5]
    var givenRating: Int?
    var selectedIndexRowofBookList: Int?
    private var previouslySelectedCell: UITableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ratingsCellreuseId, for: indexPath)
        
        // Configure the cell...
        
        if let rating = givenRating {
            if rating == indexPath.row {
                cell.accessoryType = .checkmark
                previouslySelectedCell = cell
            }
            
        }
        cell.textLabel?.text = String(ratings[indexPath.row])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        previouslySelectedCell?.accessoryType = .none
        
        guard let cell = selectedCell else {
            return
        }
        
        BRServiceTransactionManager.sharedInstance.addRatingforBook(index: selectedIndexRowofBookList, withRating: ratings[indexPath.row]) { (response) in
            
            switch(response) {
                
            case .success(let result):
                
                print(result)
                
            case .error(let errorInfo):
                
                print(errorInfo)
            }
        }
        
        cell.accessoryType = .checkmark
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let deSelectedCell = tableView.cellForRow(at: indexPath)
        
        guard let cell = deSelectedCell else {
            return
        }
        cell.accessoryType = .none
    }
    

}
