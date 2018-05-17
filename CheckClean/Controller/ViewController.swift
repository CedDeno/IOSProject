//
//  ViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/04/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase

protocol protoLogin: NSObjectProtocol {
    func recupUser(_ user: User)
}

class ViewController: UIViewController{

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    weak var delegate: protoLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnConnection(_ sender: Any) {
        if let log =  login.text, let pass = password.text {
            Auth.auth().signIn(withEmail: log, password: pass, completion: { (user, error) in
                if (error == nil){
                
                   if let recupUser = user {
                    
                    self.delegate?.recupUser(recupUser)
                    }
                } else {
                    let alert = UIAlertController(title: "Error de Connection", message: "Email ou Password incorrect", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            })
        }
    }
    
}

