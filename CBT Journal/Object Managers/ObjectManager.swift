//
//  ObjectManager.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ObjectManager {
 
    //Variables
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Functions
    func formatDateLong(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }//End formatDateLong()
    
    func saveToDatabase(){
        print("<> Shinobi <> saveToDatabase <>")
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    }//End saveToDatabase()
    
}
