//
//  File.swift
//  RememberView
//
//  Created by pegasus on 2016/11/26.
//  Copyright © 2016年 Kelly. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
  
  // MARK: - Properties
  
  var name: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: - NSCoding
  
  // persistent path on the file system where data will be saved and loaded
  static var archivePath: String {
    get {
      var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      dir.appendPathComponent("meals", isDirectory: true)
      return dir.path
    }
  }
  
  
  struct MealProperty {
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
  }
  
  // save data
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: MealProperty.name)
    aCoder.encode(photo, forKey: MealProperty.photo)
    aCoder.encode(rating, forKey: MealProperty.rating)
  }
  
  // load data
  required convenience init?(coder aDecoder: NSCoder) {
    
    let name = aDecoder.decodeObject(forKey: MealProperty.name) as! String
    let photo = aDecoder.decodeObject(forKey: MealProperty.photo) as? UIImage
    let rating = aDecoder.decodeInteger(forKey: MealProperty.rating)
    
    // Must call designated initializer.
    self.init(name: name, photo: photo, rating: rating)
  }
  
  // MARK: - init
  
  init?(name: String, photo: UIImage?, rating: Int) {
    
    // init self
    self.name = name
    self.photo = photo
    self.rating = rating
    
    // init super
    super.init()
    
    // init should fail if no name or rating negative
    if name.isEmpty || rating < 0 {
      return nil
    }
  }
}
