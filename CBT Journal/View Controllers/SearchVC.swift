//
//  SearchVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/11/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit

class SearchVC: UIViewController,  UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    override func viewDidLoad() {
        print("xX_ SearchVC _Xx")
        print("## viewDidLoad ##")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        stringOfArrayTopics = kakashi.findAllTopics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func doit(){
        
    }
    
    //Variables
    let kakashi = PageManager()
    let Jonathan = ObjectManager()
    var searchTopic: String?
    var arrayOfPages: [Page] = []
    var stringOfArrayTopics = ""
    
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func backButtonPressed(_ sender: UIButton) {
        print("@@ backButtonPressed @@")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func findButtonPressed(_ sender: UIButton) {
        print("@@ findButtonPressed @@")
        textField.resignFirstResponder()
        engageSearchMechanism()
    }
    
    func engageSearchMechanism(){
        searchTopic = textField.text
        textField.text = ""
        arrayOfPages = kakashi.searchByTopic(topic: searchTopic!)
        tableView.reloadData()
    }
    
    //TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }//End numberOfSections()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //MARK: returning 1 for the AllTopics Cell
            return 1
        } else {
            return arrayOfPages.count
        }
    }//End numberOfRowsInSection()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: Section 0 is the AllTopics Cell
            //MARK: Below is code to make the AllTopics Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "Topic List Cell") as! CustomCellSearchVCAllTopics
            cell.allTopicsLabel.text = stringOfArrayTopics
            tableView.cellLayoutMarginsFollowReadableWidth = true
            return cell
        } else {
            //MARK: Section 1 is the cells that represent the pages
            //MARK: Below is the code for making cells that are of the found pages
            let cell = tableView.dequeueReusableCell(withIdentifier: "Entry Cell", for: indexPath) as! CustomCellSearchVCExpandingCell
            cell.set(pageObject: arrayOfPages[indexPath.row])
            return cell
        }
    }//End cellForRowAt()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("## didSelectRowAt ##")
        if indexPath.section != 0 {
            let cell = arrayOfPages[indexPath.row]
            cell.expanded = !cell.expanded
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    //Functions
    
    //MARK: Code Below for when the user hits enter on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("## textFieldShouldReturn ##")
        engageSearchMechanism()
        textField.resignFirstResponder()
        return true
    }//End textFieldShouldReturn
    
    //MARK: Code Below for when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}//End Class
