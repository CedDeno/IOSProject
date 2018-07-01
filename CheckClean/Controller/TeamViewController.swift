//
//  TeamViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 25/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase

class TeamViewController: UIViewController {

    var ref: DatabaseReference!
    var bulding: Bulding!
    var tabUser = [UserDB]()
    
    @IBOutlet weak var teamTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bName = UserDefaults.standard.string(forKey: "BuldingName")
        let bAddress = UserDefaults.standard.string(forKey: "BuldingAddress")
        let bId = UserDefaults.standard.string(forKey: "BuldingId")
        bulding = Bulding(name: bName!, address: bAddress!, id: bId!)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = bulding.name
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "addUser"),style: .plain, target: self, action: #selector(addUser))
        findAllUsers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    @objc func addUser() {
        let storyboard =  UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "AddTeamViewController") as! AddTeamViewController
        view.bulding = self.bulding
        self.present(view, animated: true, completion: nil)
    }
    func findAllUsers() {
        tabUser.removeAll()
        
        ref = Database.database().reference(withPath: "Buldings")
        ref.queryOrderedByKey().queryEqual(toValue: bulding.id).observe(.value) { (data) in
            
            for items in data.children {
                let item = items as! DataSnapshot
                let listeUsers = item.childSnapshot(forPath: "user")
                
                for users in listeUsers.children {
                    
                    let user = users as! DataSnapshot
                    
                    let refuser = Database.database().reference(withPath: "Users")
                    refuser.queryOrderedByKey().queryEqual(toValue: user.key).observe(.value, with: { (dataSnapshop) in
                        
                        for userByBulding in dataSnapshop.children {
                            self.tabUser.append(UserDB(snap: userByBulding as! DataSnapshot))
                        }
                        self.teamTableview.reloadData()
                    })
                }
            }
            
        }
    }

}
extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tabUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListUserTableViewCell", for: indexPath) as! ListUserTableViewCell
        
        cell.setCell(users: tabUser[indexPath.row]) 
        return cell
    }
    
    
}
