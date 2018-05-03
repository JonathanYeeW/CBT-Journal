//
//  DayShinobi.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DayShinobi{
    
    //Variables
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let Jonathan = Shinobi()
    let Kakashi = PageShinobi()
    //Functions
    func saveToDatabase(){
        print("<> DayShinobi <> saveToDatabase <>")
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }//End
    
    func createDay(){
        print("<> DayShinobi <> createDay <>")
        let item = NSEntityDescription.insertNewObject(forEntityName: "Day", into: managedObjectContext) as! Day
        item.createdAt = Date()
        saveToDatabase()
    }//End
    
    func fetchAllDays() -> [Day]{
        print("<> DayShinobi <> fetchAllDays <>")
        var array: [Day] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        do {
            let result = try managedObjectContext.fetch(request)
            array = result as! [Day]
        } catch {
            print("\(error)")
        }
        return array
    }//End
    
    func checkIfTodayAlreadyCreated() -> Bool {
        let array = fetchAllDays()
        for day in array{
            if Jonathan.formatDateLong(date: day.createdAt!) == Jonathan.formatDateLong(date: Date()){
                print("<> We already have the Day, will not be created <>")
                return true
            }
        }
        return false
    }//End
  
      func deleteAllDays(){
        print("<> DayShinobi <> deleteAllDays <>")
        var array = fetchAllDays()
        let counter = array.count
        var x = 0
        while x < counter {
            let item = array[0]
            managedObjectContext.delete(item)
            array.remove(at: 0)
            x += 1
        }
        saveToDatabase()
    }
    
    func deleteSingleDay(dayObject: Day){
        print("<> DayShinobi <> deleteSingleDay <>")
        Kakashi.deletePagesForDay(dayObject: dayObject)
        managedObjectContext.delete(dayObject)
        Jonathan.saveToDatabase()
    }
    
    
//    func fetchSingleDay() -> Day {}
//    func fetchDayWith() -> Day {}
//    func updateDay(){}
//    func deleteDay(){}
  
    
}//End Class
