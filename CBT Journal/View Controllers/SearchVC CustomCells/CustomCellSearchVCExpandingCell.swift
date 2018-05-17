//
//  CustomCellSearchVCExpandingCell.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/11/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//
//MARK: This CustomCell is for the expanding cells on SearchVC
//MARK: On Storyboard, is labeled as "Entry Cell"

import Foundation
import UIKit
class CustomCellSearchVCExpandingCell: UITableViewCell {
    
    let objectManager = ObjectManager()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hiddenSummary: UILabel!

    //MARK: call this set function in cellForRowAt()
    func set(pageObject: Page){
        let temp = pageObject.myDay?.createdAt
        dateLabel.text = objectManager.formatDateLong(date: temp!)
        hiddenSummary.text = pageObject.expanded ? pageObject.summary : ""
    }//End set()
}//End Class
