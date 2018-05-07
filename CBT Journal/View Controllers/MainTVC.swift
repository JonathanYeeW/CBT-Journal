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
        if Naruto.checkIfTodayAlreadyCreated() == false {
            Naruto.createDay()
        }
        ReloadTableView()
    }//End
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }//End
    
// ======================= Variables =======================
    let Jonathan = Shinobi()
    let Naruto = DayShinobi()
    var dayArray: [Day] = []
    
// ======================= Outlets =======================
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("@@ addButtonPressed @@")
        if Naruto.checkIfTodayAlreadyCreated() == false {
            Naruto.createDay()
        }
        ReloadTableView()
    }
    // ======================= TableView Functions =======================
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayArray.count
    }//End
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Today"
            cell.backgroundColor = UIColor(red:0.02, green:0.93, blue:1.00, alpha:1.0)
        } else {
            cell.textLabel?.text = Jonathan.formatDateLong(date: (dayArray[indexPath.row].createdAt)!)
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
        Naruto.deleteSingleDay(dayObject: dayObject)
        ReloadTableView()
    }//End
    
// ======================= Functions =======================
    func ReloadTableView(){
        print("## ReloadTableView ##")
        dayArray = Naruto.fetchAllDays()
        dayArray = dayArray.sorted(by: {$0.createdAt! > $1.createdAt!})
        tableView.reloadData()
    }//End ReloadTableView()
}//End Class
