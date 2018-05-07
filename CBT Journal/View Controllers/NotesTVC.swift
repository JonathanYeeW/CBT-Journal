//
//  NotesTVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
class NotesTVC: UITableViewController {
    override func viewDidLoad() {
        print(""); print("xX_ NotesTVC _Xx"); print("## viewDidLoad ##")
        super.viewDidLoad()
    }//End viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        print(""); print("xX_ NotesTVC _Xx"); print("## viewWillAppear ##")
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }//End didReceiveMemoryWarning()
    
    //Variables
    let Jonathan = Shinobi()
    var pageObject: Page?
    var typeSwitch = 0
    
    //Outlets
    @IBAction func unwindfromInputVCtoNotesTVC(segue: UIStoryboardSegue){
        print("@@ unwindfromInputVCtoNotesTVC @@")
        let source = segue.source as! InputVC
        if source.typeSwitch == 0 {
            print("> The Event")
            pageObject?.event = source.textView.text
        } else if source.typeSwitch == 1 {
            print("> Initial Thoughts")
            pageObject?.initialThoughts = source.textView.text
        } else if source.typeSwitch == 2 {
            print("> Initial Feelings")
            pageObject?.initialFeelings = source.textView.text
        } else if source.typeSwitch == 3 {
            print("> New Thoughts")
            pageObject?.thoughts = source.textView.text
        } else if source.typeSwitch == 4 {
            print("> New Feelings")
            pageObject?.feelings = source.textView.text
        } else if source.typeSwitch == 5 {
            print("> Summary")
            pageObject?.summary = source.textView.text
        }
        pageObject?.title = source.textField.text
        Jonathan.saveToDatabase()
    }
    
    //TableView Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }//End numberOfRowsInSection()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! CustomCellNotesTVCTitleCell
            cell.pageObject = pageObject
            if pageObject?.title == "Title" {
                cell.textField.text = ""
            } else {
                cell.textField.text = pageObject?.title
            }
            cell.textField.delegate = cell
            return cell
        } else {
            tableView.rowHeight = 75
            let array = ["The Event", "Initial Thoughts", "Initial Feelings", "New Thoughts", "New Feelings", "Summary"]
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(array[indexPath.row-1])", for: indexPath)
            // MARK: I'm saying below that if the attribute hasn't been updated, the corresponding cell will display white
            print(">>> Creating a Cell, Checking for cell.backgroundColor")
            print(">> indexPath.row is \(indexPath.row) and indexPath.section is \(indexPath.section)")
            if indexPath.row == 1 {    
                print("> WE 0")
                print("> MARK: I'm checking what the pageObject.event is \(pageObject?.event!)")
                if pageObject?.event! != "" {cell.backgroundColor = UIColor.white}
            } else if indexPath.row == 2 {
                print("> WE 1")
                if pageObject?.initialThoughts! != "" {cell.backgroundColor = UIColor.white}
            } else if indexPath.row == 3 {
                print("> WE 2")
                if pageObject?.initialFeelings! != "" {cell.backgroundColor = UIColor.white}
            } else if indexPath.row == 4 {
                print("> WE 3")
                if pageObject?.thoughts! != "" {cell.backgroundColor = UIColor.white}
            } else if indexPath.row == 5 {
                print("> WE 4")
                if pageObject?.feelings! != "" {cell.backgroundColor = UIColor.white}
            } else if indexPath.row == 6 {
                print("> WE 5")
                if pageObject?.summary! != "" {cell.backgroundColor = UIColor.white}
            }
            return cell
        }
    }//End cellForRowAt
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("## didSelectRowAt ##")
        performSegue(withIdentifier: "segueToInputVC", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("## prepare ##")
        if segue.identifier == "segueToInputVC" {
            print("> segueToInputVC")
            let ip = sender as! IndexPath
            typeSwitch = ip.row
            let controller = segue.destination as! InputVC
            controller.pageObject = pageObject
            controller.typeSwitch = ip.row-1
        }
    }
    
    //Functions
    
}//End Class
