//
//  BuldingStructurViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 18/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase

class BuldingStructurViewController: UIViewController {
    
    var ref: DatabaseReference!
    var numberCheck = false
    var idBulding: String!
    
    @IBOutlet weak var numOffices: UITextField!
    @IBOutlet weak var numMettingRoom: UITextField!
    @IBOutlet weak var numOpenSpaces: UITextField!
    @IBOutlet weak var RelaxingSpace: UITextField!
    @IBOutlet weak var numToillette: UITextField!
    @IBOutlet weak var numShowers: UITextField!
    @IBOutlet weak var Restaurant: UITextField!
    @IBOutlet weak var numParking: UITextField!
    @IBOutlet weak var numKichinettes: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.ref = Database.database().reference(withPath: "BuldingStruct")
        ref.queryOrderedByKey().queryEqual(toValue: idBulding).observe(.value) { (data) in
            for bulding in data.children {
                let info = bulding as! DataSnapshot
                self.numKichinettes.text = info.childSnapshot(forPath: "kitchinettes").value as? String
                self.numOffices.text = info.childSnapshot(forPath: "offices").value as? String
                self.numParking.text = info.childSnapshot(forPath: "parking").value as? String
                self.numShowers.text = info.childSnapshot(forPath: "showers").value as? String
                self.numOpenSpaces.text = info.childSnapshot(forPath: "openSpace").value as? String
                self.RelaxingSpace.text = info.childSnapshot(forPath: "relaxingSpace").value as? String
                self.numToillette.text = info.childSnapshot(forPath: "wc").value as? String
                self.Restaurant.text = info.childSnapshot(forPath: "restaurant").value as? String
                self.numMettingRoom.text = info.childSnapshot(forPath: "mettingRoom").value as? String
            }
        }
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func checknumber(_ sender: UITextField) {
        
        let passRegEx = "^[0-9]*$"
        let passTest = NSPredicate(format:"SELF MATCHES[c] %@", passRegEx)
        let check = passTest.evaluate(with: sender.text)
        
        if check && !(sender.text?.isEmpty)! {
            sender.backgroundColor = UIColor.green
            self.numberCheck  = true
        } else {
            sender.backgroundColor = UIColor.red
            self.numberCheck  = false
        }
    }

    @IBAction func btnStructureBulding(_ sender: Any) {
        if self.numberCheck {
            if let offices = numOffices.text, let openSpace = numOpenSpaces.text, let mettingRoom = numMettingRoom.text, let relaxingSapace = RelaxingSpace.text, let wc =  numToillette.text, let showers = numShowers.text, let restaurant = Restaurant.text,
                let parking = numParking.text,let kitchinettes = numKichinettes.text
                {
                    let tabStruct = [
                        "offices": offices,
                        "mettingRoom": mettingRoom,
                        "openSpace": openSpace,
                        "relaxingSpace": relaxingSapace,
                        "wc": wc,
                        "showers": showers,
                        "restaurant": restaurant,
                        "parking": parking,
                        "kitchinettes": kitchinettes
                    ]
                    self.ref = Database.database().reference()
                    ref.child("BuldingStruct").child(self.idBulding).setValue(tabStruct)
                    
            }
        }
    }
    
}
