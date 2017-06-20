//
//  Constants.swift
//  BookRefrence
//
//  Created by Rajeshnath Chyarngayil Vishwanath on 14/06/17.
//  Copyright © 2017 Rajeshnath Chyarngayil Vishwanath. All rights reserved.
//

import Foundation

struct Constants {
    static let RatingsCellreuseId = "RatingsCell"
    static let BookInfoCellreuseId = "BookInfoCell"
    static let RatingsTableViewControllerID = "RatingsTableViewControllerID"
}

enum ImageAsset: String {
    case notRated = "GreyStars.png"
    case oneStar = "1Star.png"
    case twoStars = "2Stars.png"
    case threeStars = "3Stars.png"
    case fourStars = "4Stars.png"
    case fiveStars = "5Stars.png"
}
