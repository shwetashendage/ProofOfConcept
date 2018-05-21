//
//  POCTableViewCell.swift
//  ProofOfConcept
//
//  Created by Shweta Shendage on 13/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

import UIKit
import SnapKit

class POCTableViewCell: UITableViewCell {
  
  let titleLabel = UILabel()
  let imageProfile = UIImageView()
  let descriptionLabel = UILabel()
  let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    titleLabel.textColor = UIColor.darkGray
    contentView.addSubview(titleLabel)
    
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    descriptionLabel.textColor = UIColor.lightGray
    contentView.addSubview(descriptionLabel)
    
    imageProfile.contentMode = .scaleAspectFit
    imageProfile.image = #imageLiteral(resourceName: "default-user-image")
    contentView.addSubview(imageProfile)
    
    
    activityIndicator.hidesWhenStopped = true
    contentView.addSubview(activityIndicator)
    
    let padding:UIEdgeInsets = UIEdgeInsetsMake(POCConstants.POCPadding, POCConstants.POCPadding, POCConstants.POCPadding, POCConstants.POCPadding)
    
    imageProfile.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(contentView).offset(padding.top)
      make.left.equalTo(contentView).offset(padding.left)
      make.height.width.equalTo(POCConstants.POCImageHeightWidth)
      make.bottom.lessThanOrEqualTo(-padding.bottom)
      
    }
    
    activityIndicator.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(imageProfile.snp.centerX)
      make.centerY.equalTo(imageProfile.snp.centerY)
    }
    
    titleLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(imageProfile.snp.top)
      make.right.equalTo(contentView).offset(-padding.right)
      make.left.equalTo(imageProfile.snp.right).offset(padding.right)
    }
    
    descriptionLabel.snp.makeConstraints { (make) -> Void in
      
      make.top.equalTo(titleLabel.snp.bottom).offset(padding.bottom)
      make.right.equalTo(contentView).offset(-padding.right)
      make.left.equalTo(imageProfile.snp.right).offset(padding.right)
      make.bottom.lessThanOrEqualTo(-padding.bottom)
    }
    
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
