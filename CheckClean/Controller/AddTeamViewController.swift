//
//  AddTeamViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 12/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Toast_Swift
import Firebase

class AddTeamViewController: UIViewController {
    
    var ref: DatabaseReference!
    var bulding = Bulding()
    var s: String = "Team"
    @IBOutlet weak var emailToCheck: UITextField!
    @IBOutlet weak var statusTeam: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func checkAddTeam(_ sender: Any) {
        var insert = false
        if  statusTeam.isOn {
            s = "Client"
        }
        if let myEmail = emailToCheck.text {
            self.ref = Database.database().reference(withPath: "Users")
            
            self.ref.queryOrderedByKey().observe(.value) { (Data) in
                let data = Data.children
                for users in data {
                    let users = users as! DataSnapshot
                    let dataEmail = users.childSnapshot(forPath: "email").value as! String
                    if let email =  self.emailToCheck.text {
                        if email == dataEmail {
                            
                            let id = users.childSnapshot(forPath: "id").value as! String
                            self.ref.child(id).child("buldings").child(self.bulding.id).setValue(self.bulding.id)
                            
                            self.ref = Database.database().reference(withPath: "Buldings")
                            self.ref.child(self.bulding.id).child("user").child(id).setValue(self.s)
                            insert =  true
                            break
                        }
                    }
                    
                }
                if insert {
                    
                    self.view.makeToast("User à bien été ajouter au bulding", title: "User Ajuter", image: UIImage(named: "attention"), completion: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                } else {
                
                    self.view.makeToast("Email pas trouver, veuillez s'inscire.", title: "User Pas Ajuter", image: UIImage(named: "attention"), completion: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }
            
        }
        
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailToCheck.resignFirstResponder()
        super.touchesBegan(touches, with: event)
    }
    
}
