//
//  ToDO.swift
//  CheckClean
//
//  Created by Machado Sergio on 20/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation
import RealmSwift

class ToDO: Object  {
    
    @objc dynamic var id = 0
    @objc dynamic var texte: String!
    @objc dynamic var date: String!
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(ToDO.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }

}
