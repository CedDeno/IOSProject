//
//  ToDOViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 20/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit

class ToDOViewController: UIViewController {
    
    var bulding: Bulding!

    @IBOutlet weak var todoTableview: UITableView!
    @IBOutlet weak var todoLabel: UITextField!
    
    var listTodo = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func todoBtn(_ sender: Any) {
        if let text = todoLabel.text{
            if !text.isEmpty {
                let date = Date()
                let dateformat = DateFormatter()
                dateformat.dateFormat = "dd.MM.yyyy - H:m"
                
                let todo = ToDO()
                
                if let buldingName = bulding.name {
    
                    todo.texte = "\(buldingName) \(text)"
                    
                }
                
                todo.date = dateformat.string(from: date)
                todo.id = todo.IncrementaID()
                
                DatabaseManager.sharedInstance.addData(object: todo)
                /*
                listTodo.append(text)
                todoTableview.reloadData()
                 */
                todoLabel.text = ""
                todoTableview.reloadData()
 
            }
        }
    }
    
    @IBAction func tapTodo(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}

extension ToDOViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseManager.sharedInstance.getDataFromDB().count
       // return self.listTodo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let textLabel = DatabaseManager.sharedInstance.getDataFromDB()[indexPath.row].texte
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        if let index = textLabel?.index(of: " ") {
            
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: textLabel!, attributes: [NSAttributedStringKey.font: UIFont(name: "Georgia", size: 18.0)!])
            myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location:0,length: index.encodedOffset))
            cell.textLabel?.attributedText = myMutableString
        } else {
            cell.textLabel?.text = textLabel
        }
        
        
        cell.detailTextLabel?.text = DatabaseManager.sharedInstance.getDataFromDB()[indexPath.row].date
        return cell
            
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = DatabaseManager.sharedInstance.getDataFromDB()[indexPath.row]
            DatabaseManager.sharedInstance.deleteFromDb(object: item)
            self.todoTableview.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
}
