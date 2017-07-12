//
//  Constants.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 14/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation

struct Constants {
    
    // UITableviewCell resuse ID's
    
    static let RatingsCellreuseId = "RatingsCell"
    static let BookInfoCellreuseId = "BookInfoCell"
    
    // StoryBoard ID's
    
    static let RatingsTableViewControllerID = "RatingsTableViewControllerID"
    static let ShowBookDetailTableViewControllerID = "ShowBookDetailControllerID"
    
    // segue ID's
    
    static let showBookDetailSegueId = "showBookDetail"
    
    // Button titles
    
    struct ButtonTitle {
        
        static let Edit = "Edit"
        static let Done = "Done"
        static let Cancel = "Cancel"
        static let Close = "Close"
        
    }
    
}

enum ImageAsset: String {
    case notRated = "GreyStars.png"
    case oneStar = "1Star.png"
    case twoStars = "2Stars.png"
    case threeStars = "3Stars.png"
    case fourStars = "4Stars.png"
    case fiveStars = "5Stars.png"
}
