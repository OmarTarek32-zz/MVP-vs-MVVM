//
//  User.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import Foundation

struct User {
    
    var name: String
    var mobileNumber: String
    var email: String
    var gender: Gender
    
    init(name: String, mobileNumber: String, email: String, gender: Gender) {
        self.name = name
        self.mobileNumber = mobileNumber
        self.email = email
        self.gender = gender
    }

}
