//
//  Errors.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import Foundation

enum RegisterFormError: Error {
    case emptyName
    case invalidMobileNumber
    case invalidEmailAddress
    
    var localizedDescription: String {
        
        switch self {
        case .emptyName:
            return "Please, enter your name"
        case .invalidMobileNumber:
            return "Please, enter a valid mobile number"
        case .invalidEmailAddress:
            return "Please, enter a valid email address"
        }
        
    }
}
