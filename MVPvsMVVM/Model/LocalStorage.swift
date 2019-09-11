//
//  UserSession.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/10/19.
//  Copyright © 2019 development. All rights reserved.
//

import Foundation

class LocalStorage {
    
    var user: User?
    static let `default` = LocalStorage()
    
    private init() {
        
        user = getUser()
    }
    
    // get the user from remote or from local, based on your business
    private func getUser() -> User? {

        return User(name: "Omar Tarek", mobileNumber: "01007336222", email: "dev.omartarek@gmail.com", gender: .male)
    }
}
