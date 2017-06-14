//
//  AddBookInfoTableViewController.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 08/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class AddBookInfoTableViewController: UITableViewController {
    
    
    @IBOutlet weak var bookNameTextField: UITextField!
    
    @IBOutlet weak var authorNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func Done(_ sender: UIBarButtonItem) {
        
        guard let bookName = bookNameTextField.text, let authorName = authorNameTextField.text else {
            
            return
            
        }
        
        let book = Book(bookTitle: bookName, authorName: authorName)
        
        BRServiceTransactionManager.sharedInstance.addBookInfo(book: book) { (response) in
            
            switch (response) {
                
            case .success(let flag):
                
                if flag {
                    
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    print("Data insertion failed")
                    self.dismiss(animated: true, completion: nil)
                }
                
            case .error(let errorInfo):
                
                print(errorInfo)
                
            }
            
            
        }
        
    }
    
}
