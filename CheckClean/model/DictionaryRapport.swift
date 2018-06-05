//
//  DictionaryRapport.swift
//  CheckClean
//
//  Created by Machado Sergio on 2/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation

class DictionaryRapport {
    var zone: [String:[ZoneControl]]!
    
    init() {
    }
    
    init(lieux: String, zone: ZoneControl) {
            self.zone[lieux]?.append(zone)
    }
}
