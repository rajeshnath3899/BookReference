//
//  Book.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 07/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation

struct Book {
    
    let title: String
    let author: String
    var rating: Int?
    
    init(bookTitle: String, authorName: String) {
         title = bookTitle
         author = authorName
    }
    
    
}
