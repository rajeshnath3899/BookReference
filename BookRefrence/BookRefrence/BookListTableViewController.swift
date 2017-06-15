//
//  BookListTableViewController.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 07/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {
    var bookList: [Book]?
    var lastSelectedIndexPathRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        BRServiceTransactionManager.sharedInstance.getAllBookInfo { (response) in
            
            switch(response) {
                
            case .success(let books):
                
                self.bookList = books
                self.tableView.reloadData()
                
            case .error(let errorInfo):
                
                print(errorInfo)
                
            }
            
        }
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
            
            return 1
        }
        
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BookInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.BookInfoCellreuseId, for: indexPath) as! BookInfoTableViewCell
        
        // Configure the cell...
        
        cell.booktitleLabel.text = bookList?[indexPath.row].title
        cell.bookAuthorLabel.text = bookList?[indexPath.row].author
        
        if let rating  = bookList?[indexPath.row].rating {
            
            let starImage = Rating(rawValue: rating)?.image
            
            cell.ratingImageView?.image = starImage
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let ratingsViewController: RatingsSelectionTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.ratingsStoryBoardId) as? RatingsSelectionTableViewController  else {
            return
        }
        
        // ratingsViewController.delegate = self
        lastSelectedIndexPathRow = indexPath.row
        ratingsViewController.selectedIndexRowofBookList = indexPath.row
        ratingsViewController.givenRating = bookList?[indexPath.row].rating
        
        self.navigationController?.pushViewController(ratingsViewController, animated: true)
        
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
