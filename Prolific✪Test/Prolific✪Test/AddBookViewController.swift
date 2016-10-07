//
//  AddBookViewController.swift
//  Prolific✪Test
//
//  Created by Guang on 5/4/16.
//  Copyright © 2016 Guang. All rights reserved.
//
import UIKit
internal final class AddBookViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addTitle: UITextField!
    @IBOutlet weak var addAuthor: UITextField!
    @IBOutlet weak var addCatories: UITextField!
    @IBOutlet weak var addPublisher: UITextField!
    @IBOutlet weak var submitButtonOutlet: UIButton!
    //var book = Book(dictionary: [:])
    var bookContent : JsonDictionary = [:]
    lazy var networkController = NetworkControllerO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        //submitButtonOutlet.enabled = false
        
//        if (checkTextField(textField: UITextField) == false) {
//            
//        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func addDelegates()  {
        addTitle.delegate = self
        addAuthor.delegate = self
        addCatories.delegate = self
        addPublisher.delegate = self
    }
    // MARK : Submit
    @IBAction func submitButtonAction(sender: AnyObject) {
//        if let title = book?.title{
//        }
        //let postBook = Book(dictionary: bookContent)
        let submitString = "📖 \(bookContent["title"]) by \(bookContent["title"])is about to be added"
        let addBookalertVC = UIAlertController(title:nil, message: submitString, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Great💥submit", style: .Default){ _ in
             self.networkController.postBook(self.bookContent, completion: { _ in
                self.dismissViewControllerAnimated(true, completion: nil)
             })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){ _ in
            self.submitButtonOutlet.setTitle("Submit 📖 again", forState: .Normal)
        }
        addBookalertVC.addAction(cancelAction)
        addBookalertVC.addAction(okAction)
        presentViewController(addBookalertVC, animated: true, completion: nil)
       /*
        if let title = book.title {
            if let author = book.author {
                let submitString = "📖 \(title) by \(author) is about to be added"
                let addBookalertVC = UIAlertController(title:nil, message: submitString, preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Great💥submit", style: .Default){ _ in
                    self.networkController.postAbook(self.book) { result in
                        print("result = \(result) book added\(self.book.dictionary)")
                    }
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){ _ in
                    self.submitButtonOutlet.setTitle("Submit 📖 again", forState: .Normal)
                }
                addBookalertVC.addAction(cancelAction)
                addBookalertVC.addAction(okAction)
                presentViewController(addBookalertVC, animated: true, completion: nil)
            }
        }
 */
    }
    @IBAction func BackButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func titleInput(sender: UITextField) {
        checkTextField(sender)
        print ("title check")
        bookContent["title"] = sender.text ?? ""
    }
    @IBAction func authorInput(sender: UITextField) {
        checkTextField(sender)
        print ("author  check")
        bookContent["author"] = sender.text ?? ""
    }
    @IBAction func catagrpyInput(sender: UITextField) {
        checkTextField(sender)
        print ("catagory  check")
        bookContent["catagory"] = sender.text ?? ""
        resignFirstResponder()
    }
    @IBAction func publisher(sender: UITextField) {
        checkTextField(sender)
        print ("publisher checker")
        bookContent["publisher"] = sender.text ?? ""
    }
    @objc internal func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == addTitle){
            addAuthor.enabled = true
            addAuthor.becomeFirstResponder()
            return true
        }
        if (textField == addAuthor) {
            addCatories.enabled = true
            addCatories.becomeFirstResponder()
            return true
        }
        if (textField == addCatories) {
            addPublisher.enabled = true
            addPublisher.becomeFirstResponder()
            return true
        }
        if (textField == addPublisher){
            submitButtonOutlet.enabled = true
            view.endEditing(true)
            submitButtonOutlet.setTitle("📖 submit", forState: .Normal)
            print(bookContent)
            return true
        }
        return false
    }
   
//    func textFieldShouldEndEditing(textField: UITextField) {
//        if(checkTextField(textField) == false){
//            alertViewActive("Need to put content")
//        }
//    }
    
    private func checkTextField(textField: UITextField) -> Bool {
//        let input = textField.text.flatMap { x in
//            return x
//        } ?? ""
//        if (input.isEmpty){
//            alertViewActive("Need to put content here")
//        }
//        return input.isEmpty
        // var textStatus: Bool let components = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).filter { !$0.isEmpty }
        
        let input = textField.text?.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).filter{(!$0.isEmpty)}
        if (input?.count == 0){
            alertViewActive("Need to put content here")
            return false
        }
        return true
//        let input = textField.text.flatMap({ x in
//            
//            if (x.isEmpty & x.characters.count)
//            
//            
//            return x
//       })
        
        //return input
    
//        {
//            textStatus = input.isEmpty
//            if textStatus {
//                alertViewActive("Need to put content here")
//            }
//        }
        
    }
    private func alertViewActive(missingText : String) {
        let alertController = UIAlertController(title: "\(missingText)", message: "", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default){(action) in
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
}