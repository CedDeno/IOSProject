//
//  TabBarViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 25/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var bulding: Bulding?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mytab = self.viewControllers
        
        let todoCtr = mytab![0] as! ToDOViewController
        todoCtr.bulding = bulding
        
        //let checkDialy = mytab[1]  as!
        
        let checkMonthly = mytab![2] as! RapportAnnuelViewController
        checkMonthly.idbulding = bulding?.id
        checkMonthly.buldin = bulding
        
        let teamCtr = mytab![3] as! TeamViewController
        teamCtr.bulding = bulding
        
        let shemaBulding = mytab![4] as! BuldingStructurViewController
        shemaBulding.idBulding = bulding?.id
    }

}
