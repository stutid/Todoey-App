//
//  ViewController.swift
//  Todoey App
//
//  Created by Stuti on 13/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit
import CoreData

class TodoeyTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var itemArray = [Item]()

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
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        saveItems()
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
            let item = Item(context: self.context)
            item.title = textfield.text!
            item.done = false
            self.itemArray.append(item)
            self.saveItems()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Load Items method
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do{
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error loading data, \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Save Items method
    func saveItems() {
        do{
            try context.save()
        }
        catch {
            print("Error saving data, \(error)")
        }
        self.tableView.reloadData()
    }
}



//MARK: - Search bar methods
extension TodoeyTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
//        else {
//            let request: NSFetchRequest = Item.fetchRequest()
//            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//            request.predicate = predicate
//            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//            request.sortDescriptors = [sortDescriptor]
//            loadItems(with: request)
//        }
    }
    
    
    
    
    
    
}
