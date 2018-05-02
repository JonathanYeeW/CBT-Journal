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
