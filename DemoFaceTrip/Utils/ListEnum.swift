//
//  ListEnum.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

/// enum for catagory in model
enum catagoryType{
    case hotelType
    case experienceType
    case localGuideType
    case travelAgencyType
    case attractionType
    case themParkType
    case foodTourType
    case cityTourType
    case None
}

// enum for home screen
enum typeCatagoryForHome{
    case ForYou
    case Hotel
    case Experience
    case CityTour
    case FoodTour
    case LocalGuide
    case TravelAgency
    case Attraction
}

enum typeOfCategoryMenu{
    case Recentlies
    case WishList
    case BestSeller
    case FTPickes
    case Attractions
    case Daytrip
    case MultiDayTrip
    case Activities
    case Experiences
    case None
}
