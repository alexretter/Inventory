//
//  DetailViewController.swift
//  Inventory
//
//  Created by Alex Retter on 5/3/16.
//  Copyright © 2016 ReGroup. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    
    }()
    
    var dateFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text = dateFormatter.stringFromDate(item.dateCreated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(animated: Bool) {
        //Save changes to item
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueField = valueField.text,
            value = numberFormatter.numberFromString(valueField) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func takePicture(sender: AnyObject) {
   
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        //Get image from info dict
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //Put image on imageView
        imageView.image = image
        
        //Take imagePicker off screen 
        dismissViewControllerAnimated(true, completion: nil)
    }


}
