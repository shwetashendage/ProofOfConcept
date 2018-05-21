//
//  POCConstants.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 21/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

struct POCConstants {
  
  static let POCFactsUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
  static let POCNoImage = "No Image"
  
  static let POCTableViewIdentifier = "factsTableView"
  static let POCTableViewCellIdentifier = "pocCell"

  static let POCPadding = CGFloat(10)
  static let POCImageHeightWidth = 100

  struct POCKeys {
    static let POCHeaderTitle = "title"
    static let POCArray = "rows"
    static let POCTitle = "title"
    static let POCImage = "imageHref"
    static let POCDescription = "description"
  }
  
}
