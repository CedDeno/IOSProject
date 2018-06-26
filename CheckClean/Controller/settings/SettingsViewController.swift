//
//  SettingsViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 22/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    var container: ContainerViewController?
    
    var currentChildViewController: UIViewController?
    @IBOutlet weak var segmentNav: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Deconection", style: .plain, target: self, action: #selector(logout))
        
        currentChildViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
        
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
    
}
