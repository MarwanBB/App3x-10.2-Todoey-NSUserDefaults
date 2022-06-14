//
//  ViewController.swift
//  App3x 10.1 Todoey
//
//  Created by Marwan Elbahnasawy on 04/06/2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var itemArray = ["This shall be deleted in the beging of viewDidLoad"]

    override func viewDidLoad() {
        super.viewDidLoad()
        itemArray.removeAll()
        if let safeItemsArray = defaults.array(forKey: "Items") as? [String] {
            itemArray = safeItemsArray
        }
        
    }

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Todoey", message: "Add a new memo", preferredStyle: .alert)
        var alertTextField = UITextField()
        let alertAction = UIAlertAction(title: "Add", style: .default) { action in
            if let safeAlertTextFieldText = alertTextField.text {
                self.itemArray.append(safeAlertTextFieldText)
                self.defaults.set(self.itemArray, forKey: "Items")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alert.addAction(alertAction)
        alert.addTextField { textField in
            textField.placeholder = "Memo Title"
            alertTextField = textField
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
}

