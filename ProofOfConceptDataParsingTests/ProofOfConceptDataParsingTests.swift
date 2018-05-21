//
//  ProofOfConceptDataParsingTests.swift
//  ProofOfConceptDataParsingTests
//
//  Created by Shweta Shendage on 21/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import XCTest

class ProofOfConceptDataParsingTests: XCTestCase {
  
  var systemUnderTest : POCServiceClass!
  
  override func setUp() {
    super.setUp()
    systemUnderTest = POCServiceClass()
    systemUnderTest.defaultSession = URLSession(configuration: .default)
    
  }
  
  override func tearDown() {
    systemUnderTest = nil
    super.tearDown()
  }
  
  func testCheckIfDataParsedCorrectly(){
    
    let makeExpectation = expectation(description: "Status code: 200")
    
    let url = URL(string: POCConstants.POCFactsUrl)
    let dataTask = systemUnderTest?.defaultSession.dataTask(with: url!) {
      data, response, error in
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          self.systemUnderTest?.createFactsArray(data!)
          makeExpectation.fulfill()
        }
      }
    }
    dataTask?.resume()
    waitForExpectations(timeout: 60, handler: nil)
    
    XCTAssertGreaterThan(systemUnderTest!.factsArray.count, 0, "No Elements")
  }
  
}
