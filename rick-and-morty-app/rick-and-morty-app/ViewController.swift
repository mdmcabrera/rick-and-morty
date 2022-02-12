//
//  ViewController.swift
//  rick-and-morty-app
//
//  Created by Mar Cabrera on 03/02/2022.
//

import UIKit
import RealmSwift

// This is a temporary class in order to test basic CRUD functionality
// Future development: Map response from API in order to store all the data

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var characters: [Character] = []
    let realm = try! Realm()
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        fetchAllCharacters()
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func fetchAllCharacters() {
        // Fetches character from API
        self.startActivityIndicator()
        Task {
            let characters = await fetchCharacters()
            self.stopActivityIndicator()
            if let characters = characters {
                for character in characters {
                    self.characters.append(character)
                    
                    try! realm.write {
                        realm.add(character, update: .modified)
                    }
                }
            }
            tableView.reloadData()
        }
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var textField = UITextField()

        let alert = UIAlertController(title: "Create new character", message: "", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new character"
            
            textField = alertTextField
        }

        let action = UIAlertAction(title: "Add", style: .default) { action in
            // Only add character is !texfield.isEmpty
            print(textField.text)
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table View Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterCell

        let character = characters[indexPath.row]
        cell.nameLabel.text = character.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            characters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Remove object from database
            
            let characters = [Character]() // fill in your items values
            // then just grab the ids of the items with
            let ids = characters.map { $0.id }

            // query all objects where the id in not included - Replace with Swift Realm Query API
            let objectsToDelete = realm.objects(Character.self).filter("NOT id IN %@", ids)

            realm.delete(objectsToDelete)
            
        }
    }
}

