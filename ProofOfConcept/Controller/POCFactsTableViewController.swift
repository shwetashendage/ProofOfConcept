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
  var cache : NSCache<AnyObject,AnyObject>!
  
  //      MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "POC"
    
    tableView.register(POCTableViewCell.self, forCellReuseIdentifier: POCConstants.POCTableViewCellIdentifier)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
    tableView.separatorInset = .zero
    tableView.accessibilityIdentifier = POCConstants.POCTableViewIdentifier
    
    //Refresh control
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    
    cache = NSCache()
    
    // Call JSON Feed
    getData()
    
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //  MARK: - Public Methods
  func getData() {
    
    if reachability.connection == .none {
      showAlertWith(title: "", message: POCConstants.POCNoInternetMessage)
    }
    else{
      
      //Show Progress View
      showIndicator()
      
      //End Refreshing
      refreshControl?.endRefreshing()
      
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
          self.showAlertWith(title: "", message: POCConstants.POCErrorMessage )
        }
        
      }
    }
  }
  
  func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
      self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(action)
    present(alertController, animated: true, completion: nil)
  }
  //  MARK: - MBProgressHUD
  func showIndicator() {
    
    DispatchQueue.main.async {
      self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
      self.spinnerActivity?.label.text = POCConstants.POCNoProgressViewMessage;
      self.spinnerActivity?.isUserInteractionEnabled = true;
    }
  }
  
  func hideIndicator() {
    DispatchQueue.main.async {
      self.spinnerActivity?.hide(animated: true)
    }
  }
  //  MARK: - Refresh Control
  @objc func pullToRefresh(){
    getData()
  }
  
}

//    MARK: - UITableViewDataSource
extension POCFactsTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return factsArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: POCConstants.POCTableViewCellIdentifier, for: indexPath) as! POCTableViewCell
    
    cell.titleLabel.text = factsArray[indexPath.row].title
    cell.descriptionLabel.text = factsArray[indexPath.row].description
    cell.imageProfile.image = #imageLiteral(resourceName: "default-user-image")
    
    if factsArray[indexPath.row].imageHref == POCConstants.POCNoImage {
      
    }else if cache.object(forKey: factsArray[indexPath.row].imageHref! as AnyObject) != nil {
      cell.imageProfile.image = (cache.object(forKey: factsArray[indexPath.row].imageHref! as AnyObject) as! UIImage)
    }
    else{
      
      cell.activityIndicator.startAnimating()
      
      service.getImageFromUrlString(urlString: factsArray[indexPath.row].imageHref!){ image, error in
        
        cell.activityIndicator.stopAnimating()
        
        //Check For Image
        if let thereIsImage = image {
          
          DispatchQueue.main.async{
            if let updateCell = tableView.cellForRow(at: indexPath) as? POCTableViewCell {
              
              updateCell.imageProfile.image = thereIsImage
              
            }
          }
          
          self.cache.setObject(thereIsImage, forKey: self.factsArray[indexPath.row].imageHref! as AnyObject)
        }
        //Check for Error Message
        if !error.isEmpty {
          
        }
        
        
      }
    }
    
    return cell
    
  }
  
}

