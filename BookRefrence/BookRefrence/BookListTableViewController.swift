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
        
        self.tableView.allowsSelectionDuringEditing = true
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.BookInfoCellreuseId, for: indexPath) as? BookInfoTableViewCell else {
            fatalError("BookInfoTableViewCell is not in the table view")
        }
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == Constants.showBookDetailSegueId) {
            
            guard let selectedIndex: IndexPath = tableView.indexPathForSelectedRow else { return }
            
            guard let bookDetailViewController: BookDetailViewController = segue.destination as? BookDetailViewController else {
                
                return
            
            }
            
            bookDetailViewController.bookDetailPassed = bookList?[selectedIndex.row]
            bookDetailViewController.selectedBookIndexPassed = selectedIndex.row
            
            
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            ServiceTransactionManager.sharedInstance.removeBookFrom(index: indexPath.row, completion: { [weak self] (response) in
                
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
    
    // fetch all the books from the datastore
    
    func fetchBooks() {
        
        ServiceTransactionManager.sharedInstance.getAllBooks { [weak self] (response)  in
            
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
        
        var image: UIImage? {
            
            switch self {
                
            case .notRated:
                
                return ImageAsset.notRated.image
                
            case .oneStar:
                
                return ImageAsset.oneStar.image
                
            case .twoStars:
                
                return ImageAsset.twoStars.image
                
            case .threeStars:
                
                return ImageAsset.threeStars.image
                
            case .fourStars:
                
                return ImageAsset.fourStars.image
                
            case .fiveStars:
                
                return ImageAsset.fiveStars.image
                
            }
        }
    }
}


extension ImageAsset {
    var image : UIImage? {
        return UIImage(named: self.rawValue)
    }
}
