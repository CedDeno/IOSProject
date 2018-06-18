//
//  RapportViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 15/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import MessageUI
import Toast_Swift

class RapportViewController: UIViewController {

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imageRapport: UIImageView!
    @IBOutlet weak var textComment: UITextView!
    @IBOutlet weak var textSujet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTakePicture(_ sender: Any) {
    }
    
    
    @IBAction func btnSend(_ sender: Any) {
        if let tSujet = textSujet.text, let tCommt = textComment.text {
            if !tSujet.isEmpty && !tCommt.isEmpty {
                
            } else {
                self.view.makeToast("veuillez introduir un Titre ou un Commentaire")
            }
    }
    }
}
