//
//  CustomTableView.swift
//  SignUpPractice
//
//  Created by 태우 on 2020/05/26.
//  Copyright © 2020 taewoo. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
  
  override var contentSize: CGSize {
    didSet {
      self.invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    self.layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
