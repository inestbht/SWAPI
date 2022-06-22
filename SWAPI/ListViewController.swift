//
//  ListViewController.swift
//  SWAPI
//
//  Created by Samuel Pena on 6/21/22.
//  Copyright © 2022 Samuel Pena. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characters = Characters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        characters.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\(indexPath.row+1) of \(characters.characterArray.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == characters.characterArray.count-1 && characters.urlString.hasPrefix("http") {
            characters.getData {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        cell.textLabel?.text = "\(indexPath.row+1). \(characters.characterArray[indexPath.row].name)"
        return cell
    }
    
    
}
