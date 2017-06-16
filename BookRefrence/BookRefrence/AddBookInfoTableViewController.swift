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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        BRServiceTransactionManager.sharedInstance.addBook(book: book) { [weak self] (response) in
            
            guard let weakSelf = self else { return }
            
            switch (response) {
                
            case .success(let flag):
                
                if flag {
                    
                    weakSelf.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    print("Data insertion failed")
                    weakSelf.dismiss(animated: true, completion: nil)
                }
                
            case .error(let errorInfo):
                
                print(errorInfo)
                
            }
            
        }
    }
}
