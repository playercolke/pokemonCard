//
//  AddViewController.swift
//  Pokemon_Cards
//
//  Created by 郑植 on 7/1/20.
//  Copyright © 2020 CSE 390. All rights reserved.
//

import UIKit
import CoreData


class PokemonViewController: UIViewController, UITextFieldDelegate {
    
    var currentPokemon: Pokemon?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var npn: UITextField!
    @IBOutlet weak var generation: UITextField!
    @IBOutlet weak var strength: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentPokemon != nil {
            name.text = currentPokemon!.name
            type.text = currentPokemon!.type
            npn.text = currentPokemon!.npn
            generation.text = currentPokemon!.generation
            strength.text = currentPokemon!.strength
        }
        let textFields: [UITextField] = [name, type, npn, generation, strength]
        for textField in textFields {
            textField.addTarget(self, action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currentPokemon == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentPokemon = Pokemon(context: context)
        }
        currentPokemon?.name = name.text
        currentPokemon?.type = type.text
        currentPokemon?.npn = npn.text
        currentPokemon?.generation = generation.text
        currentPokemon?.strength = strength.text
        return true
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        self.savePokemon()
    }
    
    @objc func savePokemon() {
        appDelegate.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
