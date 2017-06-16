//
//  DataOperations.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 08/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation

enum Result <T> {
    case success(T)
    case error(String)  // would be needed in case of real network transactions
}

class BRServiceTransactionManager {
    
    private var dataStore: [Book] // using swift array
    
    static let sharedInstance = BRServiceTransactionManager()

    private init() {
        
        dataStore = []
    }
    
    //add a book
    
    func addBook(book: Book, completion: @escaping (Result<Bool>) -> Void) {
        
        dataStore.append(book)
        completion(.success(true)) // on sucess 
    }
    
    //fetch all books
    
    func getAllBooks(completion: @escaping (Result<[Book]>) -> Void) {
        completion(.success(dataStore))
        //completion(.error("error info")) /* if network call fails with error */
 
    }
    
    //add rating for book
    func addRatingforBookOf(index:Int?,withRating rating: Int,completion: @escaping (Result<Bool>) -> Void) {
        
        if let bookIndex = index {
            
            var book: Book = dataStore[bookIndex]
            book.rating = rating
            
            dataStore[bookIndex] = book
            completion(.success(true))
            
        } else {
            completion(.error("Book index not found"))
        }
        
    }
    
    
    

}
