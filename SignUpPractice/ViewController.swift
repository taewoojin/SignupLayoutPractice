//
//  ViewController.swift
//  SignUpPractice
//
//  Created by 태우 on 2020/05/26.
//  Copyright © 2020 taewoo. All rights reserved.
//

import UIKit

enum FieldType {
  case textField
  case textView
}

struct Dummy {
  var title: String
  var type: FieldType
}


protocol SignupDelegate: class {
  func reloadLayout()
  func setTarget(component: UIView?)
}


class ViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var tableView: CustomTableView!
  
  var targetComponent: UIView?
  
  let dummyData = [
    Dummy(title: "ID", type: .textField),
    Dummy(title: "Password", type: .textField),
    Dummy(title: "Name", type: .textField),
    Dummy(title: "Birthday", type: .textField),
    Dummy(title: "Address", type: .textView),
    Dummy(title: "Gender", type: .textField),
    Dummy(title: "Email", type: .textField),
    Dummy(title: "Phone", type: .textField),
    Dummy(title: "Style", type: .textField),
    Dummy(title: "Note", type: .textView)
  ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.estimatedRowHeight = 80
    tableView.isScrollEnabled = false
    tableView.separatorStyle = .none
    
    addNotification()
    hideKeyboardWhenTappedAround()
  }
  
  private func addNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardDidShow),
      name: UIResponder.keyboardDidShowNotification,
      object: nil)
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillBeHidden),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }
  
  @objc func keyboardDidShow(notification: Notification) {
    let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    guard let keyboardHeight = keyboardSize?.height else { return }
    
    let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
    
    if let target = targetComponent {
      let componentFrame = target.convert(target.bounds, to: self.scrollView)
      scrollView.scrollRectToVisible(componentFrame, animated: true)
    }
  }
  
  @objc func keyboardWillBeHidden(notification: Notification) {
    let contentInsets = UIEdgeInsets.zero
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false  // Gesture가 인식되도 touch 정보를 뷰에 전달하도록 설정
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dummyData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let data = dummyData[indexPath.row]
    
    switch data.type {
    case .textField:
      let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
      cell.signupDelegate = self
      cell.titleLabel.text = data.title
      return cell
      
    case .textView:
      let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as! TextViewCell
      cell.signupDelegate = self
      cell.titleLabel.text = data.title
      return cell
      
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension ViewController: SignupDelegate {
  func reloadLayout() {
    UIView.setAnimationsEnabled(false)
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
    UIView.setAnimationsEnabled(true)
  }
  
  func setTarget(component: UIView?) {
    self.targetComponent = component
  }
}

