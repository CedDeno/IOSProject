//
//  ToDOViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 20/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit

class ToDOViewController: UIViewController {

    @IBOutlet weak var todoTableview: UITableView!
    @IBOutlet weak var todoLabel: UITextField!
    
    var listTodo = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func todoBtn(_ sender: Any) {
        if let text = todoLabel.text{
            if !text.isEmpty {
                listTodo.append(text)
                todoTableview.reloadData()
                todoLabel.text = ""
            }
        }
    }
    

}

extension ToDOViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTodo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) 
        cell.textLabel?.text = listTodo[indexPath.row]
        return cell
    }
    
    
}
