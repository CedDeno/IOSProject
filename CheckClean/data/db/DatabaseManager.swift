//
//  DatabaseManager.swift
//  CheckClean
//
//  Created by Machado Sergio on 23/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    private var   database:Realm
    static let   sharedInstance = DatabaseManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() ->   Results<ToDO> {
        let results: Results<ToDO> =   database.objects(ToDO.self).sorted(byKeyPath: "id")
        return results
    }
    
    func addData(object: ToDO)   {
        try! database.write {
            database.add(object, update: true)
        }
    }
    
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: ToDO)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
 
}
