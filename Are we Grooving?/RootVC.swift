//
//  RootVC.swift
//  Are we Grooving?
//
//  Created by Ryan Kistner on 1/13/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit

class RootVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Root loaded!")
        nameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
}

