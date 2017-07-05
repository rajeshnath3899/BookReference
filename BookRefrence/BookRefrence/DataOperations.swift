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

class ServiceTransactionManager {
    
    private var dataStore: [Book] // using swift array
    
    static let sharedInstance = ServiceTransactionManager()

    private init() {
        
        dataStore = []
    }
    
    //add a book
    
    func add(_ book: Book, completion: @escaping (Result<Bool>) -> Void) {
        
        dataStore.append(book)
        completion(.success(true)) // on sucess 
    }
    
    //fetch all books
    
    func getAllBooks(completion: @escaping (Result<[Book]>) -> Void) {
        
        if dataStore.count > 0 {
            completion(.success(dataStore))
        } else{
            completion(.error("No Books"))
        }
        
        
    }

    //add rating for book
    func addRatingforBookAt(index position:Int?,withRating rating: Int,completion: @escaping (Result<Bool>) -> Void) {
        
        if let bookIndex = position {
            
            var book: Book = dataStore[bookIndex]
            book.rating = rating
            
            dataStore[bookIndex] = book
            completion(.success(true))
            
        } else {
            completion(.error("Book index not found"))
        }
        
    }
    
    // removing a book 
    func removeBookFrom(index: Int, completion: @escaping (Result<[Book]>) -> Void) {
        
        if dataStore.count > 0 {
            
            dataStore.remove(at: index)
            completion(.success(dataStore))
            
        } else {
            completion(.error("No books to delete"))
        }
        
    }
    
    
    func removeBooks() {
        
        
    }
    
}
