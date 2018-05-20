//
//  Bulding.swift
//  CheckClean
//
//  Created by Machado Sergio on 11/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation
import Firebase

class Bulding {
    
    var id: String!
    var name: String?
    var address: String?
    
    init() {
    }
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    init(snap: DataSnapshot) {
        
        self.id = snap.key
        self.name =  snap.childSnapshot(forPath: "name").value as! String
        self.address = snap.childSnapshot(forPath: "address").value as! String
    }
}
