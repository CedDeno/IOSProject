//
//  User.swift
//  CheckClean
//
//  Created by Machado Sergio on 11/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation
import Firebase

class UserDB {
    var id: String!
    var name: String?
    var lastname: String?
    var phone: String?
    var email: String!
    var buldings = [Bulding]()
    
    
    init() {
    }
    
    init(name: String, lastname: String, phone: String) {
        self.name = name
        self.lastname = lastname
        self.phone = phone
    }
    
    init(snap: DataSnapshot) {
        self.name = snap.childSnapshot(forPath: "name").value as! String
        self.lastname = snap.childSnapshot(forPath: "last").value as! String
        self.phone = snap.childSnapshot(forPath: "phone").value as! String
        self.email = snap.childSnapshot(forPath: "email").value as! String
    }
    
    func addBulding(bulding: Bulding) {
        self.buldings.append(bulding)
    }
    
    func removeBulding (bulding: Bulding)  {
        if let index = self.buldings.index(where: {$0 === bulding}){
            self.buldings.remove(at: index)
        }
    }
}
