//
//  PasswordChangeViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 22/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class PasswordChangeViewController: UIViewController {

    @IBOutlet weak var textPassword: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancell: UIButton!
    let alerte = UIAlertController()
    var actionButton: UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alerte.title = "Password"
    }
    
    @IBAction func changeData(_ sender: Any) {
        
        if let pass = password.text, let repass = repeatPassword.text {
            
            if !pass.isEmpty && !repass.isEmpty && pass == repass {
                
                updatePassword(value: pass)
                
            } else {
                alerte.message = NSLocalizedString("TOAST_CHANGE_PASSWORD_ERROR", comment: "")
                actionButton = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alerte.addAction(actionButton!)
                self.present(alerte, animated: true) {
                    
                }
                
            }
        }
        
    }
    
    func updatePassword(value: String) {
        
        let ref = Auth.auth().currentUser
        ref?.updatePassword(to: value, completion: { (error) in
            
            if error == nil {
                self.alerte.message =  NSLocalizedString("TOAST_CHANGE_PASSWORD_SUCCESS", comment: "")
                self.actionButton = UIAlertAction(title: "ok", style: .default, handler: { (alertAction) in
                    self.logout()
                })
                self.alerte.addAction(self.actionButton!)
                self.present(self.alerte, animated: true, completion: {
                    
                })
            } else {
                self.alerte.message = NSLocalizedString("TOAST_CHANGE_PASSWORD_ERROR", comment: "")
                self.actionButton = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                self.alerte.addAction(self.actionButton!)
                self.present(self.alerte, animated: true) {
                    
                }
            }
        })
    }
    
    @objc func logout() {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            try! Auth.auth().signOut()
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
        }
    }
    
    @IBOutlet weak var cancellData: UIButton!
    
    @IBAction func cancellData(_ sender: Any) {
        self.password.text = ""
        self.repeatPassword.text = ""
    }
}
