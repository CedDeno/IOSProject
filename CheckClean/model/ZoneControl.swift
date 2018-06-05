//
//  ZoneControl.swift
//  CheckClean
//
//  Created by Machado Sergio on 2/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation
import UIKit

class ZoneControl {
    var title: String!
    var description: String!
    var tabImage: [UIImage]?
    var rating: Float!
    
    init(title: String, description:String, rating:Float, tabimage:[UIImage] = [UIImage]() ) {
        self.title = title
        self.description = description
        self.rating = rating
        self.tabImage = tabimage
        
    }
}
