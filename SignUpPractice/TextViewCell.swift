//
//  TextViewCell.swift
//  SignUpPractice
//
//  Created by 태우 on 2020/05/26.
//  Copyright © 2020 taewoo. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var textViewHeight: NSLayoutConstraint!
  
  weak var signupDelegate: SignupDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
    
    textView.delegate = self
    textView.isScrollEnabled = false
    textView.backgroundColor = .lightGray
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func textViewDidChange(_ textView: UITextView) {
    let fitFrame = CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude)
    let estimatedSize = textView.sizeThatFits(fitFrame)
    
    if estimatedSize.height >= 50 {
      textViewHeight.constant = estimatedSize.height
      signupDelegate?.reloadLayout()
    }
  }
  
}

extension TextViewCell: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    signupDelegate?.setTarget(component: textView)
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    signupDelegate?.setTarget(component: nil)
  }
}
