//
//  ServiceClass.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 21/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import Foundation

class POCServiceClass {
  
  let defaultSession = URLSession(configuration: .default)
  var dataTask: URLSessionDataTask?
  
  var errorMessage = ""
  
  let factsArray: [Any] = []
  
  func getFacts() {
    
    //Webservice call
    dataTask?.cancel()
    
    guard let url = URL(string: POCConstants.POCFactsUrl) else {
      return
    }
    
    dataTask = defaultSession.dataTask(with: url) { data, response, error in
      defer {
        self.dataTask = nil
        
      }
      
      if let error = error {
        self.errorMessage += "Error cause: " + error.localizedDescription + "\n"
      } else if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        print(data)
      }
      
    }
    
    dataTask?.resume()
    
  }
  
}