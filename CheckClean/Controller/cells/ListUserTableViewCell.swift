//
//  ListUserTableViewCell.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/04/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit

class ListUserTableViewCell: UITableViewCell {

    @IBOutlet weak var sms: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var labelCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(users: UserDB) {
        
        if let txtName = users.lastname, let texLastName = users.name {
            
            if txtName.isEmpty || texLastName.isEmpty {
                labelCell.text = users.email
            } else {
                labelCell.text = "\(txtName) \(texLastName)"
            }
        }
    }
    
    
    @IBAction func emailFunc(_ sender: Any) {
        print("ok")
    }
    
    
    @IBAction func phoneFunc(_ sender: Any) {
        print("okk")
    }
    
}
