//
//  AddBuldingViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 11/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase

class AddBuldingViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var nameBulding: UITextField!
    @IBOutlet weak var adressBulding: UITextField!
    @IBOutlet weak var zipBulding: UITextField!
    @IBOutlet weak var villeBulding: UITextField!
    
    var checkName = false
    var checkAdress = false
    var checkZip = false
    var checkVille = false
    
    @IBOutlet weak var townBulding: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //checking si user entre donnes correctes
    
    @IBAction func textNameBuldingChange(_ sender: Any) {
        
        if let count =  self.nameBulding.text?.count {
            if count >= 3 {
                self.nameBulding.backgroundColor = UIColor.green
                self.checkName = true
            } else {
                self.nameBulding.backgroundColor = UIColor.red
                self.checkName = false
            }
        }
    }
    
    @IBAction func textAdressBuldingChange(_ sender: Any) {
        
        if let count =  self.adressBulding.text?.count {
            if count > 5 {
                self.adressBulding.backgroundColor = UIColor.green
                self.checkAdress = true
            } else {
                self.adressBulding.backgroundColor = UIColor.red
                self.checkAdress = false
            }
        }
    }
    
    @IBAction func textZipBuldingChange(_ sender: Any) {
        
        if let count =  self.zipBulding.text?.count {
            if count == 4 {
                self.zipBulding.backgroundColor = UIColor.green
                self.checkZip = true
            } else {
                self.zipBulding.backgroundColor = UIColor.red
                self.checkZip = false
            }
        }
    }
    
    @IBAction func textVilleBuldingChange(_ sender: Any) {
        
        if let count =  self.villeBulding.text?.count {
            if count > 4 {
                self.villeBulding.backgroundColor = UIColor.green
                self.checkVille = true
            } else {
                self.villeBulding.backgroundColor = UIColor.red
                self.checkVille = false
            }
        }
    }
    
    @IBAction func btnAddBulding(_ sender: Any) {
        
        if self.checkVille && self.checkZip && self.checkAdress && self.checkName {
            if let name =  self.nameBulding.text,
                let adress = self.adressBulding.text,
                let zip = self.zipBulding.text,
                let ville = self.villeBulding.text {
                
                //let newBulding = Bulding(name: name, address: "\(adress) \(zip) \(ville)")
                let userCurrent = Auth.auth().currentUser?.uid
                
                ref = Database.database().reference()
                
                let key = ref.child("Buldings").childByAutoId().key
                let user = [
                    "\(userCurrent!)": "Admin"
                ]
                let mybulding = [
                    "id": key,
                    "name": name,
                    "address": "\(adress), \(zip) - \(ville)",
                    "user": user
                    ] as [String : Any]
                
                ref.child("Buldings").child(key).setValue(mybulding)
                
                /**
                 ajoute le bulding cree dans la table user
                **/
                //ref.child("User").child(userCurrent!).updateChildValues(["buldings":[key:key] as [String : Any]])
                ref.child("Users").child(userCurrent!).child("buldings").child(key).setValue(key)
                
                let alert = UIAlertController(title: "Building Ajouter",
                                              message: "Votre bâtiment à été correctement.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
                    
                    self.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true)
                
            }
        }else {
            
            let alert = UIAlertController(title: "Veuillez corriger les champs!",
                                          message: "Veuillez remplir tous les champs ou corriger.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
}
