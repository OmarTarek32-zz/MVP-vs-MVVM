//
//  ViewController.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import UIKit

class updateProfileViewController: UIViewController {
    
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var mobileTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
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
    
    func getGenderIndex() -> Int {
        return self.genderSegmentedController.selectedSegmentIndex
    }
    
    func showAlert(withTitle title: String, andErrorMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        if let error = self.updateProfilePresenter.validateInput(name: getName(), mobileNumber: getMobileNumber(), email: getEmail()) {
            self.showAlert(withTitle: "Error", andErrorMessage: error.localizedDescription)
        } else {
            self.updateProfilePresenter.saveProfileData(name: getName(), mobileNumber: getMobileNumber(), gender: Gender(rawValue: getGenderIndex())! )
            self.showAlert(withTitle: "Success", andErrorMessage: "The profile updated successfully")
        }
    }
}

