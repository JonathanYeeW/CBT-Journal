//
//  CustomCellPageTVCExpandingCell.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/2/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//
//MARK: This CustomCell is for the ExpandingCells on PageTVC

import Foundation
import UIKit
class CustomCellPageTVCExpandingCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    //MARK: call this set function in cellForRowAt()
    func set(pageObject: Page){
        titleLabel.text = pageObject.title
        summaryLabel.text = pageObject.expanded ? pageObject.summary : ""
    }
}//End Class
