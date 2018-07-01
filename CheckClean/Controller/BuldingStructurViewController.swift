//
//  BuldingStructurViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 18/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift

class BuldingStructurViewController: UIViewController {
    
    var ref: DatabaseReference!
    var numberCheck = false
    var idBulding: String!
    
    @IBOutlet weak var labelOffices: UILabel!
    @IBOutlet weak var labelMeettingRoom: UILabel!
    @IBOutlet weak var labelOpenSpace: UILabel!
    @IBOutlet weak var labelRelaxRoom: UILabel!
    @IBOutlet weak var labelBathRoom: UILabel!
    @IBOutlet weak var labelShower: UILabel!
    @IBOutlet weak var labelRestaurant: UILabel!
    @IBOutlet weak var labelParking: UILabel!
    @IBOutlet weak var labelKitchinette: UILabel!
    
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

        idBulding = UserDefaults.standard.string(forKey: "BuldingId")
        labelOffices.text = NSLocalizedString("LABEL_QUALITY_OFFICE", comment: "")
        labelShower.text = NSLocalizedString("LABEL_QUALITY_SHOWER", comment: "")
        labelParking.text = NSLocalizedString("LABEL_QUALITY_PARKING", comment: "")
        labelBathRoom.text = NSLocalizedString("LABEL_QUALITY_WC", comment: "")
        labelOpenSpace.text = NSLocalizedString("LABEL_QUALITY_OPENSPACE", comment: "")
        labelRelaxRoom.text = NSLocalizedString("LABEL_QUALITY_RELAXROOM", comment: "")
        labelRestaurant.text = NSLocalizedString("LABEL_QUALITY_RESTAURANT", comment: "")
        labelKitchinette.text = NSLocalizedString("LABEL_QUALITY_KICHENETTE", comment: "")
        labelMeettingRoom.text = NSLocalizedString("LABEL_QUALITY_METTINGROOM", comment: "")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = UserDefaults.standard.string(forKey: "BuldingName")
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsItem))
        
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
    
    @objc func settingsItem() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
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
                    
                    self.view.makeToast(NSLocalizedString("TOAST_BULDING_STRUCT_CHANGE", comment: ""))
                    
                    self.tabBarController?.selectedIndex = 0
            }
        } else {
            self.view.makeToast(NSLocalizedString("TOAST_BULDING_STRUCT_NOT_CHANGE", comment: ""))
        }
    }
    
}
