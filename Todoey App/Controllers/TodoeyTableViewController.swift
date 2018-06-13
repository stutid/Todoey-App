//
//  ViewController.swift
//  Todoey App
//
//  Created by Stuti on 13/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit

class TodoeyTableViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Data source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //MARK:- Add Button Action
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "What do you want to add?", preferredStyle: .alert)
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Type an Item"
            textfield = alertTextfield
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let item = Item()
            item.title = textfield.text!
            self.itemArray.append(item)
            self.saveItems()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Load Items method
    func loadItems() {
        do {
            let data = try Data.init(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            itemArray = try decoder.decode([Item].self, from: data)
        }
        catch {
            print("Error in decoding: \(error)")
        }
    }
    
    //MARK: - Save Items method
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }
        catch {
            print("Error in encoding: \(error)")
        }
        tableView.reloadData()
    }
    
    
    
}

