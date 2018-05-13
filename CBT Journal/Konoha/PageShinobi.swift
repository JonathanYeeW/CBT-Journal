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
        item.title = "Topic"
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
    }//End deleteSinglePage()
    
    func searchByTopic(topic: String) -> [Page] {
        print("<> PageShinobi <> searchByTopic <>")
        let array = fetchAllPages()
        var tempArray: [Page] = []
        for object in array {
            if object.title == topic {
                tempArray.append(object)
            }
        }
        return tempArray
    }//End searchByTopic()
    
    
    func findAllTopics() -> String {
        print("<> PageShinobi <> findAllTopics <>")
        let array = fetchAllPages()
        var tempArray: [String] = []
        //MARK: Forloop below is for finding all of the topics, and the inner forloop
        // is for making sure we don't repeat any topics
        for object in array {
            var lightSwitch = false
            for title in tempArray{
                if title == object.title! {
                    lightSwitch = true
                }
            }
            if lightSwitch == false {
                tempArray.append(object.title!)
            }
        }
        //MARK: Below is for creating a single string to return
        var tempString = ""
        let counter = tempArray.count
        var x = 0
        for title in tempArray{
            x += 1
            if x == counter {
                tempString += "\(title)"
            } else {
                tempString += "\(title), "
            }
            
        }
        return tempString
    }//End findAllTopics()
    
    func updateTitle(newString: String, pageObject: Page){
        print("<> PageShinobi <> updateTitle <>")
        let item = pageObject
        item.title = newString
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
