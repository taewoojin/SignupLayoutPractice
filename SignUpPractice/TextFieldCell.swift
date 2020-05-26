//
//  TextFieldCell.swift
//  SignUpPractice
//
//  Created by 태우 on 2020/05/26.
//  Copyright © 2020 taewoo. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  weak var signupDelegate: SignupDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none

    textField.delegate = self
    textField.borderStyle = .roundedRect
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}

extension TextFieldCell: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    signupDelegate?.setTarget(component: textField)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    signupDelegate?.setTarget(component: nil)
  }
}
