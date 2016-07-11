//
//  Meal.swift
//  FoodTracker
//
//  Created by Guti on 7/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    // MARK: Archibing Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
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
        
        super.init()
        
        // Should faild if there is no name or if rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // NOTE: Only a failable initializer can return nil.
    }
    
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(self.photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(self.rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        // Call designated init.
        self.init(name: name, photo: photo, rating: rating)
    }
    
}