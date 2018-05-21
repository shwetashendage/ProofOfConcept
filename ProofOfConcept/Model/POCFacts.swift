//
//  Facts.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

class POCFacts{
  
  let title: String?
  var imageHref: String? = POCConstants.POCNoImage
  var description: String? = ""
  
  init?(title: String?, imageHref: String?, description: String?) {
    
    guard let title = title else {
      return nil
    }
    
    self.title = title
    
    if let imageHref = imageHref {
      self.imageHref = imageHref
    }
    
    if let description = description {
      self.description = description
    }
    
  }
}
