//
//  RootVC.swift
//  Are we Grooving?
//
//  Created by Ryan Kistner on 1/13/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit

class RootVC: UIViewController, UITextFieldDelegate {
    
    var gender = true

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Root loaded!")
        nameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = ""
        nameTextField.placeholder = "Name"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ nameTextField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func keyBoardWillShow(sender: NSNotification){
        self.view.frame.origin.y -= 200
    }
    @objc func keyBoardWillHide(sender: NSNotification){
        self.view.frame.origin.y += 200
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! GrooveVC
         destination.incomingName = nameTextField.text
         destination.incomingGender = self.gender
    }
    
    @IBAction func genderSelected(_ sender: UIButton) {
        print("\(sender.tag) was sent!")
        if(sender.tag == 1){
            gender = false
        }else{
            gender = true
        }
    }
    
}

