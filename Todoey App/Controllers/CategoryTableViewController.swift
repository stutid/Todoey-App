//
//  CategoryTableViewController.swift
//  Todoey App
//
//  Created by Stuti on 16/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }
    
    //MARK: - TableView Data source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    //MARK: - Add button pressed method
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField!
        let alert = UIAlertController(title: "Add Category Name", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let category = Category(context: self.context)
            category.name = textField.text!
            self.categoryArray.append(category)
            self.saveCategory()
        }
        
        alert.addTextField { (localTextField) in
            localTextField.placeholder = "Add New Category"
            textField = localTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Save category method
    func saveCategory() {
        do {
            try context.save()
        }
        catch {
            print("Error saving data, \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - Load category method
    func loadCategory() {
        let request: NSFetchRequest = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error loading data, \(error)")
        }
        self.tableView.reloadData()
    }
    

}
