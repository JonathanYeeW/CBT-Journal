//
//  CustomCellNotesTVCTitleCell.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/2/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import Foundation
import UIKit
class CustomCellNotesTVCTitleCell: UITableViewCell, UITextFieldDelegate {
    
    //Variables
    var pageObject: Page?
    let Jonathan = Shinobi()
    let Kakashi = PageShinobi()
    
    //Outlets
    @IBOutlet weak var textField: UITextField!
    
    //Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pageObject?.title = textField.text
        Jonathan.saveToDatabase()
        textField.resignFirstResponder()
        return true
    }
}//End Class
