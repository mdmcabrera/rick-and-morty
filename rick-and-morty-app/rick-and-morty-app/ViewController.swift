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
        Task {
            let characters = await fetchCharacters()
            if let characters = characters {
                for character in characters {
                    self.characters.append(character)
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
}

