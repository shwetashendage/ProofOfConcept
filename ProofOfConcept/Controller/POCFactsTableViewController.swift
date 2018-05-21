//
//  FactsTableViewController.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 21/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit

class POCFactsTableViewController: UITableViewController {
  
  let service = POCServiceClass()
  
  //    MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "POC"
    
    //    Call JSON Feed
    service.getFacts()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}


