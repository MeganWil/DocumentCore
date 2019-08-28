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
        
        // Do any additional setup after loading the view.
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
            cell.sizeLabel.text = String(document.size) + " bytes"
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
