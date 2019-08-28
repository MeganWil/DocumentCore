//
//  DocumentListViewController.swift
//  Documents
//
//  Created by Megan Wilson on 8/27/19.
//  Copyright © 2019 Megan Wilson. All rights reserved.
//

import UIKit

class DocumentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var documentTable: UITableView!
    
    
    var doc = [Document]()
    let dateForm = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "Documents"
            dateForm.dateStyle = .medium
            dateForm.timeStyle = .medium
        
        
      documentTable.rowHeight = 80.0
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        doc = Documents.get()
        documentTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        if let cell = cell as? DocumentTableViewCell{
            let document = doc[indexPath.row]
            cell.textNameLabel.text = document.name
            cell.sizeLabel.text = String("Size: \(document.size)") + " bytes"
            cell.modDateLabel.text = dateForm.string(from: document.modDate)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .destructive, title: "Remove"){
            (action, indexPath) in let document = self.doc[indexPath.row]
            Documents.delete(url: document.url)
            self.doc = Documents.get()
            
            self.documentTable.deleteRows(at: [indexPath], with: .fade)
        }
        return [remove]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selected" {
            if let destination = segue.destination as? DocumentViewController,
                let row = documentTable.indexPathForSelectedRow?.row {
                destination.docsOP = doc[row]
            }
        }
    }
    
}
