//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemManager : ItemManager = CodableItemManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addItem(_ title: String){
        let newItem = Item()
        newItem.title = title
        itemManager.addItem(newItem)
    }
    
    
    
    //MARK: -  TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.getItems()?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemManager.getItem(at: indexPath.row)
        let cell = getCell(for: indexPath)
        hydrateCell(cell: cell, item: item)
        return cell
    }
    
    func getCell(for indexPath:IndexPath) -> UITableViewCell{
        return tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    }
    
    func hydrateCell(cell :UITableViewCell, item:Item ){
        cell.textLabel?.text = item.title
        cell.accessoryType = getCellAccesoryType(item)
    }
    
    //MARK: -  TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let item = itemManager.getItem(at: indexPath.row)
        item.isDone = !item.isDone
        itemManager.update(item, at: indexPath.row)
        
        if let safeCell = cell {
            hydrateCell(cell: safeCell, item: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCellAccesoryType(_ item:Item) -> UITableViewCell.AccessoryType {
        return item.isDone ? .checkmark : .none
    }
    
    //MARK: -  Add new Itens
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let  alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default, handler: { (action) in
            self.createNewItemAndReloadTableView(textField.text!)
        })
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func createNewItemAndReloadTableView(_ title:String) {
        addItem(title)
        tableView.reloadData()
    }
}

