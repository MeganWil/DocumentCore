//
//  DocumentViewController.swift
//  Documents
//
//  Created by Megan Wilson on 8/27/19.
//  Copyright © 2019 Megan Wilson. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var docTextView: UITextView!
    
       var docsOP: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let document = docsOP {
            docTextView.text = document.content ?? ""
            titleTextField.text = document.name
            
            title = document.name
        } else {
            title = ""
        }
    }
    
    
    
    @IBAction func alteredName(_ sender: Any) {
            title = titleTextField.text
    }
    
    
    @IBAction func save(_ sender: Any) {
        guard let name = titleTextField.text else {
            return
        }
        
        Documents.save(name: name, content: docTextView.text)
        navigationController?.popViewController(animated: true)
    }


}
