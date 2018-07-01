//
//  ViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/04/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase
import Lottie

protocol protoLogin: NSObjectProtocol {
    func recupUser(_ user: User)
}

class ViewController: UIViewController{

    let animationView = LOTAnimationView(name: "checkclean")
    @IBOutlet weak var btnInscription: UIButton!
    @IBOutlet weak var btnConection: UIButton!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    weak var delegate: protoLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: LOCATION
        login.placeholder = NSLocalizedString("PLACEHOLDER_LOGIN", comment: "")
        password.placeholder = NSLocalizedString("PLACEHOLDER_PASSWORD", comment: "")
        btnConection.setTitle(NSLocalizedString("BTN_CONNECTION", comment: ""), for: UIControlState.normal)
        btnInscription.setTitle(NSLocalizedString("BTN_INSCRIPTION", comment: ""), for: .normal)
        
        btnConection.backgroundColor = UIColor(cgColor: ColorNav().getColorButton())
        btnInscription.backgroundColor = UIColor(cgColor: ColorNav().getColorButton())
        
        animationView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height/5)
        self.view.addSubview(animationView)
        animationView.animationSpeed = CGFloat(2)
        animationView.play()
        
    }
    
    @IBAction func btnConnection(_ sender: Any) {
        if let log =  login.text, let pass = password.text {
            Auth.auth().signIn(withEmail: log, password: pass, completion: { (user, error) in
                if (error == nil){
                
                   if let recupUser = user {
                    
                    self.delegate?.recupUser(recupUser)
                    }
                } else {
                    let alert = UIAlertController(title: NSLocalizedString("ALERT_LOGIN_TILTE", comment: ""), message: NSLocalizedString("ALERT_LOGIN_MESSAGE", comment: ""), preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("MESSAGE_OK", comment: ""), style: .default, handler: nil))

                    self.present(alert, animated: true)
                }
            })
        }
    }
    
}

