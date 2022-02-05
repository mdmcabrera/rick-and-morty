//
//  ViewController.swift
//  rick-and-morty-app
//
//  Created by Mar Cabrera on 03/02/2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Properties
    var characters: [Character] = []

    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        fetchCharacters()

    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func fetchCharacters() {
        Task {
            let characters = await fetchCharacter()
            for character in characters {
                self.characters.append(character)
            }
            tableView.reloadData()
        }

    }
}

//MARK: - Table View Delegate
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

