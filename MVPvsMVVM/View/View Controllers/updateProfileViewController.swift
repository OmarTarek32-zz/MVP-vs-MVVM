//
//  ViewController.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import UIKit

protocol UserProfileViewProtocol: class {

    func setName(_ name: String)
    func setMobile(_ mobile: String)
    func setEmail(_ email: String)
    func setAge(_ age: Int)
    func setGender(atIndex index: Int)
    func getName() -> String
    func getMobileNumber() -> String
    func getEmail() -> String
    func getAge() -> Int
    func getGenderIndex() -> Int
    func showAlert(withTitle title: String, andErrorMessage message: String)
}

class UpdateProfileViewController: UIViewController, UserProfileViewProtocol {
    
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var mobileTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet private var genderSegmentedController: UISegmentedControl!
    @IBOutlet private var saveButton: UIButton!
    
    var updateProfilePresenter: UpdateProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = LocalStorage.default.user
        updateProfilePresenter = UpdateProfilePresenter(user: user, viewController: self)
        
    }

    func setName(_ name: String) {
        self.nameTextField.text = name
    }
    
    func setMobile(_ mobile: String) {
        self.mobileTextField.text = mobile
    }
    
    func setEmail(_ email: String) {
        self.emailTextField.text = email
    }
    
    func setAge(_ age: Int) {
        self.ageTextField.text = String(age)
    }
    
    func setGender(atIndex index: Int) {
        self.genderSegmentedController.selectedSegmentIndex = index
    }
    
    func getName() -> String {
        return self.nameTextField.text ?? ""
    }
    
    func getMobileNumber() -> String {
        return self.mobileTextField.text ?? ""
    }
    
    func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    func getAge() -> Int {
        return Int(self.ageTextField.text ?? "0") ?? 0
    }
    
    func getGenderIndex() -> Int {
        return self.genderSegmentedController.selectedSegmentIndex
    }
    
    func showAlert(withTitle title: String, andErrorMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        self.updateProfilePresenter.saveButtonClicked()
    }
}

