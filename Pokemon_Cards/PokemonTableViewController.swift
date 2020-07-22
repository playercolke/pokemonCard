//
//  TableViewController.swift
//  Pokemon_Cards
//
//  Created by 郑植 on 7/1/20.
//  Copyright © 2020 CSE 390. All rights reserved.
//

import UIKit
import CoreData



class PokemonTableViewController: UITableViewController {
    
    var pokemons:[NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDataFromDatabase()
        tableView.reloadData()
    }
    
    func loadDataFromDatabase() {
        let setting = UserDefaults.standard
        let sortField = setting.string(forKey: Constants.kSortField)
        let sortAscending = setting.bool(forKey: Constants.kSortAscending)
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
        let sortDescriptor = NSSortDescriptor(key: sortField, ascending: sortAscending)
        let sortDescriptorArray = [sortDescriptor]
        request.sortDescriptors = sortDescriptorArray
        do {
            pokemons = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source

      override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return pokemons.count
      }
    
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemons[indexPath.row] as? Pokemon
        cell.textLabel?.text = pokemon?.name
        cell.detailTextLabel?.text = pokemon?.type
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemons[indexPath.row] as? Pokemon
        let name = selectedPokemon!.name
        let actionHandler = { (action:UIAlertAction!) -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "PokemonViewController")
                as? PokemonViewController
            controller?.currentPokemon = selectedPokemon
            self.navigationController?.pushViewController(controller!, animated: true)
        }
        
        let alertController = UIAlertController(title: "Pokemon selected", message: "\(name)) is selected", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionDetails = UIAlertAction(title: "Show Details", style: .default, handler: actionHandler)
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionDetails)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPokemon" {
            let eventController = segue.destination as? PokemonViewController
            let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
            let selectedPokemon = pokemons[selectedRow!] as? Pokemon
            eventController?.currentPokemon = selectedPokemon!
        }
    }
}
