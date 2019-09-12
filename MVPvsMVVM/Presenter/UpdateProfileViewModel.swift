//
//  RegisterPresenter.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import Foundation

class UpdateProfileViewModel {
    
    var name: Property<String>!
    var mobileNumber: Property<String>!
    var email: Property<String>!
    var age: Property<Int>!
    var gender: Property<Int>!
    
    var messageObserver: ((_ title: String, _ message: String) -> Void)?
    
    private var user: User?
    
    init(user: User?) {
        self.user = user
        
        if let user = user {
            self.setUserModel(user)
        }
    }
    
    func setUserModel(_ user: User) {
        name = Property(user.name)
        mobileNumber = Property(user.mobileNumber)
        email = Property(user.email)
        age = Property(user.age)
        gender = Property(user.gender.rawValue)
    }
    
    func validateInput(name: String, mobileNumber: String, age: Int, email: String) -> UpdateProfileFormError? {
       
        if name.isEmpty {
            return .emptyName
            
        } else if !validate(mobileNumber: mobileNumber) {
            return .invalidMobileNumber
            
        } else if !validate(email: email){
            return .invalidEmailAddress
       
        } else if age < 18 {
            return .veryYoung
        }
        
        return nil
    }
    
    func validate(mobileNumber: String) -> Bool {
        let alphaNumericRegex = "^[0-9]{11}$"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: mobileNumber)
    }
    
    func validate(email: String) -> Bool {
        let regex = "([\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7})"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    func saveButtonClicked() {
        
        if let error = self.validateInput(name: self.name.value ?? "",
                                          mobileNumber: self.mobileNumber.value ?? "",
                                          age: self.age.value ?? 0,
                                          email: self.email.value ?? "") {
            
            self.messageObserver?("Error", error.localizedDescription)
        } else {
            self.saveProfileData(name: self.name.value ?? "",
                                 mobileNumber: self.mobileNumber.value ?? "",
                                 email: self.email.value ?? "",
                                 age:  self.age.value ?? 0,
                                 gender: Gender(rawValue: self.gender.value ?? 0 )!)
            
             self.messageObserver?("Success", "The profile updated successfully")
        }
    }
    
    func saveProfileData(name: String, mobileNumber: String, email: String, age: Int, gender: Gender) {
        
        self.updateLocalStoreWithUserData(name: name, mobileNumber: mobileNumber, email: email, age: age, gender: gender)
        self.updateUserModel(name: name, mobileNumber: mobileNumber, email: email, age: age, gender: gender)
    }
    
    func updateLocalStoreWithUserData(name: String, mobileNumber: String,email: String, age: Int, gender: Gender) {
        // update local data
        LocalStorage.default.user?.name = name
        LocalStorage.default.user?.mobileNumber = mobileNumber
        LocalStorage.default.user?.gender = gender
        LocalStorage.default.user?.email = email
        LocalStorage.default.user?.age = age
    }
    
    func updateUserModel(name: String, mobileNumber: String, email: String, age: Int, gender: Gender) {
        // update the model
        self.user?.name = name
        self.user?.mobileNumber = mobileNumber
        self.user?.gender = gender
        self.user?.email = email
        self.user?.age = age
    }
    
}

