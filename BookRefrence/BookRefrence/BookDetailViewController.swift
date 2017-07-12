//
//  BookDetailViewController.swift
//  BookReview
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 11/07/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var authorNameTextField: UITextField!
    
    var bookDetailPassed: Book?
    var selectedBookIndexPassed : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValuesToFieldsAndControl()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    typealias ButtonTitle = Constants.ButtonTitle
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        
        if sender.title == ButtonTitle.Cancel {
            
            setValuesToFieldsAndControl()
            enableFieldsAndControlWith(bool: false)
            
            sender.title = ButtonTitle.Close
            editButton.title = ButtonTitle.Edit
            
        } else {
            
            navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    
    @IBAction func Edit(_ sender: UIBarButtonItem) {
        
        if sender.title == ButtonTitle.Edit {
            
            sender.title = ButtonTitle.Done
            closeButton.title = ButtonTitle.Cancel
            
            enableFieldsAndControlWith(bool: true)
            bookNameTextField.becomeFirstResponder()
            
        } else {
            
            guard let bookName = bookNameTextField.text, let author = authorNameTextField.text else {
                return
            }
            
            var updatedBook: Book = Book(bookTitle: bookName, authorName: author)
            updatedBook.rating = ratingControl.rating
            
            ServiceTransactionManager.sharedInstance.updateBookAt(index: selectedBookIndexPassed, with: updatedBook, completion: { [weak self](response) in
                
                guard let weakSelf = self else { return }
                
                switch (response) {
                    
                case .success(let result):
                    
                    print(result)
                    
                    //one data saved to store change the button titles
                    
                    sender.title = ButtonTitle.Edit
                    weakSelf.closeButton.title = ButtonTitle.Close
                    
                    weakSelf.enableFieldsAndControlWith(bool: false)
                    
                    
                    
                case .error(let error):
                    
                    print(error)
                    
                }
                
                
            })
            
            
            
        }
        
    }
    
    //enable the textfields and rating control for editing
    
    func enableFieldsAndControlWith(bool: Bool) {
        
        bookNameTextField.isEnabled = bool
        authorNameTextField.isEnabled = bool
        ratingControl.isUserInteractionEnabled = bool
        
    }
    
    // initilising the textfields with values
    
    func setValuesToFieldsAndControl() {
        
        bookNameTextField.text = bookDetailPassed?.title
        authorNameTextField.text = bookDetailPassed?.author
        if let rating = bookDetailPassed?.rating {
            
            ratingControl.rating = rating
            
        } else { ratingControl.rating = 0 }
    }
    
}
