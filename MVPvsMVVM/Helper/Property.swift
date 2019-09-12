//
//  Box.swift
//  MVPvsMVVM
//
//  Created by Omar Tarek on 9/12/19.
//  Copyright © 2019 development. All rights reserved.
//

import Foundation

class Property<Type> {
    
    private var subscribeAction :(Type?) -> () = { _ in }
    
    func subscribe(_ closure:@escaping (Type?) -> ()) {
        subscribeAction = closure
        
        if let value = value {
            self.subscribeAction(value)
        }
    }
    
    var value :Type? {
        didSet {
            subscribeAction(value)
        }
    }
    
    init(_ v :Type) {
        value = v
    }
    
}
