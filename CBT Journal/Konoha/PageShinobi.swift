//
//  PageShinobi.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class PageShinobi{

    //Variables
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let Jonathan = Shinobi()
    
    //Functions
    func createPage(dateObject: Day) -> Page {
        print("<> PageShinobi <> createPage <>")
        let item = NSEntityDescription.insertNewObject(forEntityName: "Page", into: managedObjectContext) as! Page
        item.createdAt = Date()
        item.myDay = dateObject
        item.title = "Title"
        item.event = ""
        item.feelings = ""
        item.thoughts = ""
        item.initialFeelings = ""
        item.initialThoughts = ""
        item.summary = ""
        item.expanded = false
        Jonathan.saveToDatabase()
        return item
    }
    
    func fetchAllPages() -> [Page] {
        print("<> PageShinobi <> fetchAllPages <>")
        var array: [Page] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Page")
        do {
            let result = try managedObjectContext.fetch(request)
            array = result as! [Page]
        } catch {
            print("\(error)")
        }
        return array
    }//End fetchAllPages
    
    func fetchAllPagesForDate(dateObject: Day) -> [Page] {
        print("<> PageShinobi <> fetchAllPagesForDate <>")
        let array = fetchAllPages()
        var tempArray: [Page] = []
        for object in array {
            if object.myDay == dateObject {
                tempArray.append(object)
            }
        }
        return tempArray
    }//End fetchAllPagesForDate()
    
    func deleteAllPages(){
        print("<> PageShinobi <> deleteAllPages <>")
        var array = fetchAllPages()
        let counter = array.count
        var x = 0
        while x < counter {
            let item = array[0]
            managedObjectContext.delete(item)
            array.remove(at: 0)
            x += 1
        }
        Jonathan.saveToDatabase()
    }//End deleteAllPages()
    
    func deletePagesForDay(dayObject: Day){
        print("<> PageShinobi <> deletePagesForDay <>")
        var array = fetchAllPagesForDate(dateObject: dayObject)
        let counter = array.count
        var x = 0
        while x < counter {
            let item = array[0]
            managedObjectContext.delete(item)
            array.remove(at: 0)
            x += 1
        }
        Jonathan.saveToDatabase()
    }
    
    func deleteSinglePage(pageObject: Page){
        print("<> PageShinobi <> deleteSinglePage <>")
        managedObjectContext.delete(pageObject)
        Jonathan.saveToDatabase()
    }
    
//    create
//    fetchAll
//    fetchSingle
//    fetchPagesWith
//    Update
//    Delete
//    DeleteAll
    
}
