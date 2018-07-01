//
//  ChoiceBuldingViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/04/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Lottie
import Firebase

class ChoiceBuldingViewController: UIViewController {
    
    @IBOutlet weak var textListBulding: UILabel!
    var ref: DatabaseReference!
    var tabBulding = [Bulding]()
    var currentUser: User!
    let animationView = LOTAnimationView(name: "checkclean")
    
    @IBOutlet weak var choiceBulding: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textListBulding.text = NSLocalizedString("TEXT_TITLE_LIST_BULDING", comment: "")
        
        animationView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height/5)
        self.view.addSubview(animationView)
        animationView.animationSpeed = CGFloat(2)
        animationView.play()
        
       currentUserExiste()
        
    }
    
    @IBAction func btnAddBulding(_ sender: Any) {
    }
    
    func currentUserExiste() {
        if  Auth.auth().currentUser == nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            view.modalTransitionStyle = .flipHorizontal
            view.delegate = self as! protoLogin
            self.navigationController?.present(view, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentUserExiste()
        animationView.play()
        
        self.tabBulding.removeAll()
        self.tabBulding.append(Bulding(name: NSLocalizedString("TEXT_LIST_BULDING", comment: ""), address: ""))
        self.choiceBulding.reloadAllComponents()
        self.currentUser = Auth.auth().currentUser
        
        if self.currentUser != nil {
            self.findBuldings()
        }
    }
    
    /**
     recuperations de tous les ids buldings qui appartien à un user
    **/
    func findBuldings(){
        
        ref = Database.database().reference(withPath: "Users")
        ref.queryOrderedByKey().queryEqual(toValue: self.currentUser.uid).observe(.value) { (data) in
            
            for users in data.children {
                
                let user = users as! DataSnapshot
                let buldingsUser = user.childSnapshot(forPath: "buldings")
                
                for bulding in buldingsUser.children {
                    
                    let idBulding = bulding as! DataSnapshot
                    let idB = idBulding.value as! String
                    let refB = Database.database().reference(withPath: "Buldings")
                    refB.queryOrderedByKey().queryEqual(toValue: "\(idB)").observe(.value) { (dataSnapshop) in
                        
                        for bulding in dataSnapshop.children {
                            self.tabBulding.append(Bulding(snap: bulding as! DataSnapshot))
                        }
                        
                        self.choiceBulding.reloadAllComponents()
                    }
                }
            }
            
        }
        
    }
    

}
extension ChoiceBuldingViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.tabBulding.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.tabBulding[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row != 0 {
            //sauvegarde des info du bâtiment dans l'user default
            UserDefaults.standard.set(self.tabBulding[row].id, forKey: "BuldingId")
            UserDefaults.standard.set(self.tabBulding[row].name, forKey: "BuldingName")
            UserDefaults.standard.set(self.tabBulding[row].address, forKey: "BuldingAddress")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
extension ChoiceBuldingViewController: protoLogin{
    func recupUser(_ user: User) {
        self.tabBulding.removeAll()
        self.tabBulding.append(Bulding(name: "Veuillez selectione un Bâtiment", address: ""))
        self.choiceBulding.reloadAllComponents()
        dismiss(animated: true, completion: nil)
    }
}
