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
  var factsArray: [POCFacts] = []
  let reachability = Reachability()!
  var spinnerActivity: MBProgressHUD?
  
  //      MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "POC"
    
    self.tableView.register(POCTableViewCell.self, forCellReuseIdentifier: POCConstants.POCTableViewCellIdentifier)
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 120
    self.tableView.separatorInset = .zero
    self.tableView.accessibilityIdentifier = POCConstants.POCTableViewIdentifier
    
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
      
      //Show Progress View
      self.showIndicator()
      
      //    Call Service
      service.getFacts(){ results, headerTitle, errorMessage in
        
        //Hide Progress View
        self.hideIndicator()
        
        //        Update Header Title
        if !headerTitle.isEmpty {
          self.title = headerTitle
        }
        
        //        Create facts array
        if let results = results {
          self.factsArray = results
          self.tableView.reloadData()
        }
        
        //Check for Error Message
        if !errorMessage.isEmpty {
          print("Error: " + errorMessage)
          self.showAlertWith(title: "Message", message: "Error occurred")
        }
        
      }
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
  //  MARK: - MBProgressHUD
  func showIndicator() {
    
    DispatchQueue.main.async {
      self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
      self.spinnerActivity?.label.text = "Please Wait...";
      self.spinnerActivity?.isUserInteractionEnabled = true;
    }
  }
  
  func hideIndicator() {
    DispatchQueue.main.async {
      self.spinnerActivity?.hide(animated: true)
    }
  }
  
}

//    MARK: - UITableViewDataSource
extension POCFactsTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.factsArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: POCConstants.POCTableViewCellIdentifier, for: indexPath) as! POCTableViewCell
    
    cell.titleLabel.text = self.factsArray[indexPath.row].title
    cell.descriptionLabel.text = self.factsArray[indexPath.row].description
    
    return cell
    
  }
  
}

