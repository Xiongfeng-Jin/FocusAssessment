//
//  DetailTableViewController.swift
//  pt1
//
//  Created by Jin on 9/1/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController,UITextFieldDelegate {
    
    var player:Player?
    
    @IBOutlet weak var nameField: UITextField!{
        didSet{
            nameField.delegate = self
        }
    }
    
    @IBOutlet weak var countrySeg: UISegmentedControl!
    
    @IBOutlet weak var heightField: UITextField!{
        didSet{
            heightField.delegate = self
        }
    }

    @IBOutlet weak var weightField: UITextField!{
        didSet{
            weightField.delegate = self
        }
    }
    
    @IBOutlet weak var ageField: UITextField!{
        didSet{
            ageField.delegate = self
        }
    }
    
    private func fillTextField(){
        if player != nil {
            nameField.text = player?.name ?? ""
            heightField.text = String(describing: player?.height ?? 0)
            countrySeg.selectedSegmentIndex = Player.indexFor(Country: (player?.country)!)
            weightField.text = String(describing: player?.weight ?? 0)
            ageField.text = String(describing: player?.age ?? 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(save))
        fillTextField()
    }
    
    
    @objc private func save(){
        let fieldEmpty = checkTextFieldEmpty(textField: nameField, textFieldName: "name") +
                            checkTextFieldEmpty(textField: heightField, textFieldName: "height") +
                            checkTextFieldEmpty(textField: weightField, textFieldName: "weight") +
                            checkTextFieldEmpty(textField: ageField, textFieldName: "age")
        if fieldEmpty == 0{
            if player == nil {
                player = Player(name: nameField.text!,
                                Country:Player.getCountryAt(Index: countrySeg.selectedSegmentIndex),
                                Height: Double(heightField.text!) ?? 0,
                                Weight: Double(weightField.text!) ?? 0,
                                Age: Int(ageField.text!) ?? 0)
            }
            else{
                player?.name = nameField.text!
                player?.country = Player.getCountryAt(Index: countrySeg.selectedSegmentIndex)
                player?.height = Double(heightField.text!) ?? 0
                player?.weight = Double(weightField.text!) ?? 0
                player?.age = Int(ageField.text!) ?? 0
            }
            
            
            performSegue(withIdentifier: "unwindSegue", sender: self)
        }
        
    }
    
    private func checkTextFieldEmpty(textField:UITextField, textFieldName name:String) -> Int{
        if let text = textField.text, text.isEmpty {
            emptyTextField(field: name, textField: textField)
            return 1
        }
        return 0
    }
    
    private func emptyTextField(field:String, textField:UITextField){
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(string: "empty \(field)", attributes: [NSForegroundColorAttributeName:UIColor.red])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancelKeyboard(_ sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
        heightField.resignFirstResponder()
        weightField.resignFirstResponder()
        ageField.resignFirstResponder()
    }
    

}
