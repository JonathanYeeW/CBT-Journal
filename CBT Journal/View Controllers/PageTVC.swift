//
//  PageTVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
class PageTVC: UITableViewController {
    override func viewDidLoad() {
        print(""); print("xX_ PageTVC _Xx"); print("## viewDidLoad ##")
        title = Jonathan.formatDateLong(date: (dateObject?.createdAt)!)
        super.viewDidLoad()
        ReloadTableView()
        for object in pageArray{
            object.expanded = false
        }
    }//End viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        print(""); print("xX_ PageTVC _Xx"); print("## viewWillAppear ##")
        ReloadTableView()
    }//End viewWillAppear()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }//End didReceiveMemoryWarning()
    
    // ======================= Variables =======================
    let Jonathan = Shinobi()
    let Naruto = DayShinobi()
    let Kakashi = PageShinobi()
    var pageArray: [Page] = []
    var dateObject: Day?
    
    // ======================= Outlets =======================
    // ======================= TableView Functions =======================
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }//End numberOfSections()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return pageArray.count
        }
    }//End numberOfRowsInSection()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //MARK: Below code just for the AddNewEntry... Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "Add")
            return cell!
        } else {
            //MARK: Below code for all page entries for this dateObject
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCellPageTVCExpandingCell
            cell.titleLabel.text = pageArray[indexPath.row].title
            cell.set(pageObject: pageArray[indexPath.row])
            return cell
        }
    }//End cellForRowAt()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("## prepare ##")
        if segue.identifier == "segueTonewNotesVC" {
            print("> segueTonewNotesVC")
            let controller = segue.destination as! newNotesVC
            let newPage: Page = Kakashi.createPage(dateObject: dateObject!)
            controller.pageObject = newPage
        } else if segue.identifier == "segueToEdit" {
            print("> segueToEdit")
            let ip = sender as! IndexPath
            let controller = segue.destination as! newNotesVC
            controller.pageObject = pageArray[ip.row]
        }
    }//End prepare()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("## didSelectRowAt ##")
        if indexPath.section == 0 {
            //MARK: Section 0 means that it's the AddNewEntry... Cell
            performSegue(withIdentifier: "segueTonewNotesVC", sender: indexPath)
        } else {
            //MARK: Cells that are tapped expand ? to show their summary
            let cell = pageArray[indexPath.row]
            cell.expanded = !cell.expanded
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }//End didSelectRowAt()
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }//End trailingSwipeAction()
    
    func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") {_,_,_ in
            print("## editAction ##")
            self.performSegue(withIdentifier: "segueToEdit", sender: indexPath)
        }
        action.backgroundColor = UIColor.purple
        return action
    }//End editAction
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete"){_,_,_ in
            print("## deleteAction ##")
            self.Kakashi.deleteSinglePage(pageObject: self.pageArray[indexPath.row])
            self.ReloadTableView()
        }
        action.backgroundColor = UIColor.red
        return action
    }//End deleteAction
    
    // ======================= Functions =======================
    func ReloadTableView(){
        print("## ReloadTableView ##")
        pageArray = Kakashi.fetchAllPagesForDate(dateObject: dateObject!)
        pageArray = pageArray.sorted(by: { $0.createdAt! > $1.createdAt! })
        tableView.reloadData()
    }//End ReloadTableView()
}//End Class
