//
//  RegisterPresenter.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import Foundation

class UpdateProfilePresenter {
    
    var user: User?
    
    weak var updateProfileViewController: updateProfileViewController!
    
    init(user: User?, viewController: updateProfileViewController) {
        self.user = user
        self.updateProfileViewController = viewController
        
        if let user  = self.user {
            self.updateProfileViewController.setName(user.name)
            self.updateProfileViewController.setMobile(user.mobileNumber)
            self.updateProfileViewController.setEmail(user.email)
            self.updateProfileViewController.setGender(atIndex: user.gender.rawValue)
        }
        
    }
    
    func validateInput(name: String, mobileNumber: String, email: String) -> RegisterFormError? {
       
        if name.isEmpty {
            return .emptyName
            
        } else if !validate(mobileNumber: mobileNumber) {
            return .invalidMobileNumber
            
        } else if !validate(email: email){
            return .invalidEmailAddress
        }
        
        return nil
    }
    
    func validate(mobileNumber: String) -> Bool {
        let alphaNumericRegex = "^[0-9]*$"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: mobileNumber)
    }
    
    func validate(email: String) -> Bool {
        let regex = "([\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7})"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    func saveProfileData(name: String, mobileNumber: String, gender: Gender) {
        
        // update local data
        LocalStorage.default.user?.name = name
        LocalStorage.default.user?.mobileNumber = mobileNumber
        LocalStorage.default.user?.gender = gender
        
        // update the model 
        self.user?.name = name
        self.user?.mobileNumber = mobileNumber
        self.user?.gender = gender
        
    }
    
    
    
}

