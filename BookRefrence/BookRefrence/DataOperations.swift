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

/* `ServiceTransactionManager` uses Singleton approach which is not a recommended way, its better to go for dependency injection.
 */

class ServiceTransactionManager {
    
    private var dataStore: [Book] // using swift array since no real services exist
    
    static let sharedInstance = ServiceTransactionManager()
    
    private init() {
        
        dataStore = []
    }
    
    // All API's written are considering the real network transaction
    // since no services for this app exist , swift array is used .
    
    //add a book
    
    func add(_ book: Book, completion: @escaping (Result<Bool>) -> Void) {
        
        dataStore.append(book)
        
        // network call code
        
        completion(.success(true)) // on sucess
    }
    
    //fetch all books
    
    func getAllBooks(completion: @escaping (Result<[Book]>) -> Void) {
        
        
        // network call code

        
        if dataStore.count > 0 {
            
            completion(.success(dataStore))
        } else{
            completion(.error("No Books"))
        }
        
        
    }
    
    //update details for a book
    
    func updateBookAt(index :Int?, with book: Book,completion: @escaping (Result<Bool>) -> Void) {
        
        if let bookIndex = index {
            
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
    
    
}
