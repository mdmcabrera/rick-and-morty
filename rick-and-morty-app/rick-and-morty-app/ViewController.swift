//
//  ViewController.swift
//  rick-and-morty-app
//
//  Created by Mar Cabrera on 03/02/2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Properties
    var characters = ["Character 1", "Character 2", "Character 3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterCell

        let character = characters[indexPath.row]
        cell.nameLabel.text = character

        return cell
    }
}

