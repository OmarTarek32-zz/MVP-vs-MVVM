//
//  ViewController.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import UIKit


class UpdateProfileViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var nameTextField: BindingTextField!
    @IBOutlet private var mobileTextField: BindingTextField!
    @IBOutlet private var emailTextField: BindingTextField!
    @IBOutlet private var ageTextField: BindingTextField!
    @IBOutlet private var genderSegmentedController: BindingSegmentedControl!
    @IBOutlet private var saveButton: UIButton!
    
    var updateProfileViewModel: UpdateProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let user = LocalStorage.default.user
        updateProfileViewModel = UpdateProfileViewModel(user: user)
        
        bindViewModel()
        
    }
    
    func bindViewModel() {
        
        self.updateProfileViewModel.name.subscribe{ [unowned self]  in
            self.nameTextField.text = $0
        }
        self.updateProfileViewModel.email.subscribe{ [unowned self] in
            self.emailTextField.text = $0
        }
        self.updateProfileViewModel.mobileNumber.subscribe{ [unowned self] in
            self.mobileTextField.text = $0
        }
        self.updateProfileViewModel.age.subscribe{ [unowned self] in
            self.ageTextField.text = $0 != nil ? String($0!) : ""
        }
        self.updateProfileViewModel.gender.subscribe{ [unowned self] in
            self.genderSegmentedController.selectedSegmentIndex = $0 ?? 0
        }
        
        self.nameTextField.subscribe { [unowned self] in
            self.updateProfileViewModel.name.value = $0
        }
        self.emailTextField.subscribe { [unowned self] in
            self.updateProfileViewModel.email.value = $0
        }
        self.mobileTextField.subscribe { [unowned self] in
            self.updateProfileViewModel.mobileNumber.value = $0
        }
        self.ageTextField.subscribe { [unowned self] in
            self.updateProfileViewModel.age.value = Int($0)
        }
        self.genderSegmentedController.subscribe { [unowned self] in
            self.updateProfileViewModel.gender.value = Int($0)
        }
        
        self.updateProfileViewModel.messageObserver = { [unowned self] title, message in
            self.showAlert(withTitle: title, andErrorMessage: message)
        }
    }

    func showAlert(withTitle title: String, andErrorMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        self.updateProfileViewModel.saveButtonClicked()
    }
}

