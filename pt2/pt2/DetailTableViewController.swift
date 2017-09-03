//
//  DetailTableViewController.swift
//  pt2
//
//  Created by Jin on 9/2/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.sizeToFit()
            imageView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var nameField: UITextField!{
        didSet{
            nameField.delegate = self
        }
    }
    
    @IBOutlet weak var addressField: UITextField!{
        didSet{
            addressField.delegate = self
        }
    }
    
    @IBOutlet weak var priceField: UITextField!{
        didSet{
            priceField.delegate = self
        }
    }
    
    @IBOutlet weak var dateTime: UIDatePicker!
    
    var event:Event?
    private var tookPhoto = false
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
        }
        else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker,animated: true,completion: nil)
    }
    
    private func scaleImage(image:UIImage,scale: CGFloat) -> UIImage?{
        let width = image.size.width * scale
        let height = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width:width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage{
            if let scaledImage = scaleImage(image: image, scale: 0.1) {
                imageView.image = scaledImage
                tookPhoto = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelKeyboard(_ sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
        addressField.resignFirstResponder()
        priceField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(save))
        fillEvent()
    }
    
    @objc private func save(){
        let fieldEmpty = checkTextFieldEmpty(textField: nameField, textFieldName: "name") +
            checkTextFieldEmpty(textField: priceField, textFieldName: "price") +
            checkTextFieldEmpty(textField: addressField, textFieldName: "weight")
        if !tookPhoto {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.red.cgColor
        }
        
        if fieldEmpty == 0,tookPhoto{
            updateEvent()
            performSegue(withIdentifier: "unwindSegue", sender: self)
        }
    }
    
    private func fillEvent(){
        if event != nil {
            if let name = event?.name{
                nameField.text = name
            }
            if let address = event?.address{
                addressField.text = address
            }
            if let price = event?.price{
                priceField.text = String(price)
            }
            if let image = event?.image{
                imageView.image = image
                tookPhoto = true
            }
            if let date = event?.date{
                dateTime.date = date
            }
        }
    }
    
    private func updateEvent(){
        if event == nil {
            event = Event()
        }
        if event?.name == nil || event?.name != nameField.text!{
            event?.name = nameField.text!
        }
        let p = Double(priceField.text!)
        if event?.price == nil || event?.price != p! {
            event?.price = p!
        }
        if event?.address == nil || event?.address != addressField.text! {
            event?.address = addressField.text!
        }
        if event?.image == nil || event?.image != imageView.image! {
            event?.image = imageView.image
        }
        event?.date = dateTime.date
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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }



}
