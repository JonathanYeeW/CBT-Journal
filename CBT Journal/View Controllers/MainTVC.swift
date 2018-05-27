//
//  MainTVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
class MainTVC: UITableViewController {
    override func viewDidLoad() {
        print("")
        print("xX_ MainTVC _Xx")
        print("viewDidLoad")
        super.viewDidLoad()
        if dayManager.checkIfTodayAlreadyCreated() == false {
            dayManager.createDay()
        }
        ReloadTableView()
        triggerAddButton(false)
    }//End
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }//End
    
// ======================= Variables =======================
    let objectManager = ObjectManager()
    let dayManager = DayManager()
    var dayArray: [Day] = []
    
// ======================= Outlets =======================
    
    @IBOutlet weak var addButtonLabel: UIBarButtonItem!
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("@@ addButtonPressed @@")
        if dayManager.checkIfTodayAlreadyCreated() == false {
            dayManager.createDay()
        }
        ReloadTableView()
        triggerAddButton(false)
    }
    // ======================= TableView Functions =======================
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayArray.count
    }//End
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = objectManager.formatDateLong(date: (dayArray[indexPath.row].createdAt)!)
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(red:0.64, green:0.88, blue:0.92, alpha:1.0)
        }
        return cell
    }//End
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("## didSelectRowAt ##")
        performSegue(withIdentifier: "segueToPageTVC", sender: indexPath)
    }//End
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("## prepare ##")
        if segue.identifier == "segueToPageTVC" {
            let controller = segue.destination as! PageTVC
            controller.dateObject = dayArray[(tableView.indexPathForSelectedRow?.row)!]
        }
    }//End
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("## commit editingStyle ##")
        let dayObject = dayArray[indexPath.row]
        dayManager.deleteSingleDay(dayObject: dayObject)
        ReloadTableView()
        triggerAddButton(true)
    }//End
    
// ======================= Functions =======================
    func ReloadTableView(){
        print("## ReloadTableView ##")
        dayArray = dayManager.fetchAllDays()
        dayArray = dayArray.sorted(by: {$0.createdAt! > $1.createdAt!})
        tableView.reloadData()
    }//End ReloadTableView()
    
    func triggerAddButton(_ setting: Bool){
        if setting == true {
            addButtonLabel.isEnabled = true
            addButtonLabel.tintColor = UIColor.blue
        } else {
            addButtonLabel.isEnabled = false
            addButtonLabel.tintColor = UIColor.clear
        }
    }
}//End Class
