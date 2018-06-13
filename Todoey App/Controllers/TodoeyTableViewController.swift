//
//  ViewController.swift
//  Todoey App
//
//  Created by Stuti on 13/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {

    var itemArray = ["Bring 12 Eggs", "Bring 2 litres milk", "Bring one dozen bananas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Data source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "What do you want to add?", preferredStyle: .alert)
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Type an Item"
            textfield = alertTextfield
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            self.itemArray.append(textfield.text!)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

