//
//  Meal.swift
//  FoodTracker
//
//  Created by Guti on 7/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initializer 
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // Should faild if there is no name or if rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // NOTE: Only a failable initializer can return nil.
    }
    
}