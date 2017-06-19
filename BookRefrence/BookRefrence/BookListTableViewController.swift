//
//  BookListTableViewController.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 07/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {
    
    private var lastSelectedIndexPathRow: Int?

    private var bookList: [Book]? {
        didSet {
            if let noOfBooks = bookList?.count {
                if noOfBooks > 1 {
                    self.editButtonItem.isEnabled = true
                } else if noOfBooks == 0 {
                    self.editButtonItem.isEnabled = false
                    self.setEditing(false, animated: true)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.editButtonItem.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchBooks()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let books = bookList else {
            return 0
        }
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BookInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.BookInfoCellreuseId, for: indexPath) as! BookInfoTableViewCell
        
        // Configure the cell...
        
        let bookTitle = bookList?[indexPath.row].title
        let bookAuthor = bookList?[indexPath.row].author
        
        cell.booktitleLabel.text = bookTitle
        cell.bookAuthorLabel.text = bookAuthor
        
        //adding accessibility 
        cell.booktitleLabel.accessibilityLabel = bookTitle
        cell.bookAuthorLabel.accessibilityLabel = bookAuthor
        
        if let rating  = bookList?[indexPath.row].rating {
            
            let starImage = Rating(rawValue: rating)?.image
            cell.ratingImageView?.image = starImage
            
            cell.ratingImageView.accessibilityLabel = String("Rated \(rating) out of 5")

        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let ratingsViewController: RatingsSelectionTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.RatingsTableViewControllerID) as? RatingsSelectionTableViewController  else {
            return
        }
        
        // ratingsViewController.delegate = self
        lastSelectedIndexPathRow = indexPath.row
        ratingsViewController.selectedIndexRowFromBookList = indexPath.row
        ratingsViewController.givenRating = bookList?[indexPath.row].rating
        
        self.navigationController?.pushViewController(ratingsViewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            BRServiceTransactionManager.sharedInstance.removeBookFrom(index: indexPath.row, completion: { [weak self] (response) in
                
                guard let weakSelf = self else {
                    return
                }
                
                switch(response) {
                    
                case .success(let books):
                    
                    weakSelf.bookList = books
                    weakSelf.tableView.deleteRows(at: [indexPath], with: .automatic)
                    print("Book removed")

                case .error(let errorString):
                    
                    print(errorString)
                    
                }
                
            })
            
        }
        
    }
    
    
    func fetchBooks() {
        
        BRServiceTransactionManager.sharedInstance.getAllBooks { [weak self] (response)  in
            
            guard let weakSelf = self else { return }
            
            switch(response) {
                
            case .success(let books):
                weakSelf.bookList = books
                weakSelf.tableView.reloadData()
                weakSelf.editButtonItem.isEnabled = true
            case .error(let errorInfo):
                print(errorInfo)
                weakSelf.editButtonItem.isEnabled = false
                
            }
            
        }
        
    }
    
    enum Rating: Int {
        
        case notRated
        case oneStar
        case twoStars
        case threeStars
        case fourStars
        case fiveStars
        
        var image: UIImage {
            
            switch self {
                
            case .notRated:
                
                return UIImage(named: "GreyStars.png")!
                
            case .oneStar:
                
                return UIImage(named: "1Stars.png")!
                
            case .twoStars:
                
                return UIImage(named: "2Stars.png")!
                
            case .threeStars:
                
                return UIImage(named: "3Stars.png")!
                
            case .fourStars:
                
                return UIImage(named: "4Stars.png")!
                
            case .fiveStars:
                
                return UIImage(named: "5Stars.png")!
                
            }
        }
    }
}
