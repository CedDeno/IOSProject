//
//  ColorApp.swift
//  CheckClean
//
//  Created by Machado Sergio on 26/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import Foundation
import UIColor_Hex_Swift


class ColorNav {
    
    private let color_nav = UIColor("#1d566e").cgColor
    private let color_button = UIColor("#21aba5").cgColor
    
    
    func getColorNav() -> CGColor {
        return self.color_nav
    }
    
    func getColorButton() -> CGColor {
        return self.color_button
    }
    
}

