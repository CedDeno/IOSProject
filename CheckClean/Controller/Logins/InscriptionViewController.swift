//
//  InscriptionViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/04/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class InscriptionViewController: UIViewController {
    
    var ref: DatabaseReference!
    let animationView = LOTAnimationView(name: "checkclean")
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var btnEnregistre: UIButton!
    @IBOutlet weak var labelInscription: UILabel!
    @IBOutlet weak var btnCancell: UIButton!
    
    var validEmail = false
    var validPassword = false
    var validRepeatPass = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelInscription.text = NSLocalizedString("TEXT_INSCRIPTION", comment: "")
        email.placeholder = NSLocalizedString("PLACEHOLDER_LOGIN", comment: "")
        repeatPassword.placeholder = NSLocalizedString("PLACEHOLDER_REPAT_PASSWORD", comment: "")
        password.placeholder = NSLocalizedString("PLACEHOLDER_PASSWORD", comment: "")
        
        btnEnregistre.setTitle(NSLocalizedString("BTN_INSCRIPTION", comment: ""), for: .normal)
        btnEnregistre.backgroundColor = UIColor(cgColor: ColorNav().getColorButton())
        
        btnCancell.setTitle(NSLocalizedString("BTN_CANCEL", comment: ""), for: .normal)
        btnCancell.backgroundColor = UIColor(cgColor: ColorNav().getColorButton())
        
        animationView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height/5)
        self.view.addSubview(animationView)
        animationView.animationSpeed = CGFloat(2)
        animationView.play()
    }
    
    @IBAction func checkEmail(_ sender: Any) {
        if let txt = self.email.text {
            if isValid(txt) {
                self.email.backgroundColor = UIColor.green
                self.validEmail = true
            } else {
                 self.email.backgroundColor = UIColor.red
                self.validEmail = false
            }
        }
    }
    
    @IBAction func checkPassword(_ sender: Any) {
        if let txt = self.password.text {
            if passwordValid(txt) {
                self.password.backgroundColor = UIColor.green
                self.validPassword = true
            } else {
                self.password.backgroundColor = UIColor.red
                self.validPassword = false
            }
        }
    }
    
    @IBAction func checkRepeatPassword(_ sender: Any) {
        
        if self.password.text == self.repeatPassword.text {
            self.repeatPassword.backgroundColor = UIColor.green
            self.validRepeatPass = true
        } else {
            self.repeatPassword.backgroundColor = UIColor.red
            self.validRepeatPass = false
            }
    }
    
    @IBAction func Tap(_ sender: Any) {
        view.endEditing(true)
    }
    
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func passwordValid(_ pass: String) -> Bool {
        
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d$@$!%*?&]{8}"
        
        let passTest = NSPredicate(format:"SELF MATCHES[c] %@", passRegEx)
        return passTest.evaluate(with: pass)
    }
    
    @IBAction func btnInscription(_ sender: Any) {
        
        if self.validEmail && self.validPassword && self.validRepeatPass {
            
            ref = Database.database().reference()
            if let email = self.email.text, let password = self.password.text {
                
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    
                    if error == nil {
                        if let id = user?.uid, let email = user?.email {
                            let myuser = [
                                "id" : id,
                                "name" : "",
                                "last" : "",
                                "phone" : "",
                                "email" : email
                            ]
                            
                            self.ref.child("Users").child(id).setValue(myuser)
                            
                            let alert = UIAlertController(title: "ALert", message: "Votre compte a ete correctement enregistre", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (_) in
                                
                                self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        if let myerror = error {
                            let alert = UIAlertController(title: NSLocalizedString("ALERT_REGISTER_TITLE", comment: ""), message: "\(myerror.localizedDescription)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("MESSAGE_OK", comment: ""), style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                })
            }
            
        }
    }
    
    @IBAction func cancellResgistration(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
