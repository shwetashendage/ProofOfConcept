//
//  ProofOfConceptUITests.swift
//  ProofOfConceptUITests
//
//  Created by Shweta Shendage on 21/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import XCTest

class ProofOfConceptUITests: XCTestCase {

  var app: XCUIApplication!
  
  override func setUp() {
    super.setUp()
    
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testTableView() {
    
    // Assert that Table view is loaded
    let factsTableView = app.tables[POCConstants.POCTableViewIdentifier]
    XCTAssertTrue(factsTableView.exists, "The Facts tableview exists.")
    
  }
  
}
