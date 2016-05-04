//
//  AddBookViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/4/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addAuthor: UITextField!
    @IBOutlet weak var addCatories: UITextField!
    @IBOutlet weak var addPublisher: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addTitle.delegate = self
        addAuthor.delegate = self
        addCatories.delegate = self
        addPublisher.delegate = self
        
        var title = addTitle.text
        var author = addAuthor.text
        var catgory = addCatories.text
        var publisher = addPublisher.text
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil); // make the animation slower
    }
    
    @IBAction func submitButton(sender: AnyObject) {
    }
    
    
    
    func checkTextField(text: UITextField) -> Bool {
        
        
        if (text.text?.characters.count == 0) {
            return false
        }
        
        return true
    }
    
    @IBAction func titleInput(sender: UITextField) {
        if (checkTextField(sender) == false) {
            alertViewActive()
        }
    }
    @IBAction func authorInput(sender: AnyObject) {
    }
    
    @IBAction func catagrpyInput(sender: AnyObject) {
    }
    @IBOutlet weak var publisherInput: UITextField!
    
    
    func alertViewActive() {
        
        let alertController = UIAlertController(title: "Yo, a book shall have a title?", message: "", preferredStyle: .Alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
//            // ...
//        }
//        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    

}
