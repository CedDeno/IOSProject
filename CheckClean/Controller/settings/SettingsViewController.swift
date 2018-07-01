//
//  SettingsViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 22/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Toast_Swift

class SettingsViewController: UIViewController {

    var container: ContainerViewController?
    let userCurrent  = Auth.auth().currentUser?.uid
    let ref = Database.database().reference(withPath: "Users")
    
    @IBOutlet weak var labelProfil: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelFirtsName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var fieldLastName: UITextField!
    @IBOutlet weak var fieldName: UITextField!
    @IBOutlet weak var fieldPhone: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    var currentChildViewController: UIViewController?
    @IBOutlet weak var segmentNav: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelProfil.text = NSLocalizedString("TEXT_SETTING", comment: "")
        labelName.text = NSLocalizedString("LABEL_SETTING_NAME", comment: "")
        labelFirtsName.text = NSLocalizedString("LABEL_SETTING_LAST_NAME", comment: "")
        btnSave.setTitle(NSLocalizedString("BTN_SETTING_SAVE", comment: ""), for: .normal)
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: NSLocalizedString("BTN_SIGNOUT", comment: ""), style: .plain, target: self, action: #selector(logout))
        
        segmentNav.setTitle(NSLocalizedString("BTN_SETTING_MAP", comment: ""), forSegmentAt: 0)
        segmentNav.setTitle(NSLocalizedString("BTN_SETTING_PASSWORD", comment: ""), forSegmentAt: 1)
        segmentNav.setTitle(NSLocalizedString("BTN_SETTING_SETTING", comment: ""), forSegmentAt: 2)
        
        currentChildViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
        
        dataUserCurrent()
        
        if let childViewController = currentChildViewController {
            
            self.container?.addChildViewController(childViewController)
            self.container?.view.addSubview(childViewController.view)
        }
    }
    @objc func logout() {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            try! Auth.auth().signOut()
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
        }
    }
    
    func dataUserCurrent() {
        ref.child(userCurrent!).observeSingleEvent(of: .value) { (dataSnapshot) in
            
            let myUser = dataSnapshot.value as? NSDictionary
            
             self.fieldName.text = myUser!["name"] as? String ?? ""
            self.fieldLastName.text = myUser!["last"] as? String ?? ""
            self.fieldPhone.text = myUser!["phone"] as? String ?? ""
        }
    }
    
    @IBAction func segmentNavChange(_ segment: UISegmentedControl) {
       
        currentChildViewController?.view?.removeFromSuperview()
        currentChildViewController?.removeFromParentViewController()
        
        switch segment.selectedSegmentIndex {
        case 0:
            currentChildViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
            break
        case 1:
            currentChildViewController = self.storyboard?.instantiateViewController(withIdentifier: "PasswordChangeViewController")
            break
        default:
            break
        }
        
        if let childViewController = currentChildViewController {
            self.container?.addChildViewController(childViewController)
            self.container?.view.addSubview(childViewController.view)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            self.container = segue.destination as! ContainerViewController
        }
    }
    
    @IBAction func saveChangeDataUser(_ sender: Any) {
        
        if let name = fieldName.text, let lastname = fieldLastName.text, let phone = fieldPhone.text {
            
            ref.child(userCurrent!).child("name").setValue(name)
            ref.child(userCurrent!).child("last").setValue(lastname)
            ref.child(userCurrent!).child("phone").setValue(phone)
        }
    }
}

