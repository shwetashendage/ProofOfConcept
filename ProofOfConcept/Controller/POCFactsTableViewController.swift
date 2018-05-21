//
//  FactsTableViewController.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 21/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit
import Reachability

class POCFactsTableViewController: UITableViewController {
  
  let service = POCServiceClass()
  var factsArray: [Any] = []
  let reachability = Reachability()!
  
  //      MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "POC"
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 120
    self.tableView.separatorInset = .zero
    self.tableView.accessibilityIdentifier = "factsTableView"
    
    // Call JSON Feed
    getData()
    
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //  MARK: - Public Methods
  func getData() {
    if reachability.connection == .none{
      self.showAlertWith(title: "Message", message: "No Internet connection.")
    }
    else{
      //    Call Service
      service.getFacts()
    }
  }
  
  func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    let action = UIAlertAction(title: "Ok", style: .default) { (action) in
      self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
  }
  
}

//    MARK: - UITableViewDataSource
extension POCFactsTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.factsArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
    
  }
  
}

