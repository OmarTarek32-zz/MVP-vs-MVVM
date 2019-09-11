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
    
    weak var updateProfileViewController: UserProfileViewProtocol!
    
    init(user: User?, viewController: UserProfileViewProtocol) {
        self.user = user
        self.updateProfileViewController = viewController
        
        if let user  = self.user {
            self.setUserDate(user)
        }
        
    }
    
    func setUserDate(_ user: User){
        self.updateProfileViewController.setName(user.name)
        self.updateProfileViewController.setMobile(user.mobileNumber)
        self.updateProfileViewController.setEmail(user.email)
        self.updateProfileViewController.setAge(user.age)
        self.updateProfileViewController.setGender(atIndex: user.gender.rawValue)
    }
    
    func validateInput(name: String, mobileNumber: String, email: String) -> UpdateProfileFormError? {
       
        if name.isEmpty {
            return .emptyName
            
        } else if !validate(mobileNumber: mobileNumber) {
            return .invalidMobileNumber
            
        } else if !validate(email: email){
            return .invalidEmailAddress
       
        } else if user?.age ?? 0 < 18 {
            return .veryYoung
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
    
    func saveButtonClicked() {
        if let error = self.validateInput(name: updateProfileViewController.getName(),
                                          mobileNumber: updateProfileViewController.getMobileNumber(),
                                          email: updateProfileViewController.getEmail()) {
            
            self.updateProfileViewController.showAlert(withTitle: "Error", andErrorMessage: error.localizedDescription)
        } else {
            self.saveProfileData(name: updateProfileViewController.getName(),
                                 mobileNumber: updateProfileViewController.getMobileNumber(),
                                 gender: Gender(rawValue: updateProfileViewController.getGenderIndex())! )
            
            self.updateProfileViewController.showAlert(withTitle: "Success", andErrorMessage: "The profile updated successfully")
        }
    }
    
    func saveProfileData(name: String, mobileNumber: String, gender: Gender) {
        
        self.updateLocalStoreWithUserData(name: name, mobileNumber: mobileNumber, gender: gender)
        self.updateUserModel(name: name, mobileNumber: mobileNumber, gender: gender)
    }
    
    func updateLocalStoreWithUserData(name: String, mobileNumber: String, gender: Gender) {
        // update local data
        LocalStorage.default.user?.name = name
        LocalStorage.default.user?.mobileNumber = mobileNumber
        LocalStorage.default.user?.gender = gender
    }
    
    func updateUserModel(name: String, mobileNumber: String, gender: Gender) {
        // update the model
        self.user?.name = name
        self.user?.mobileNumber = mobileNumber
        self.user?.gender = gender
    }
    
}

