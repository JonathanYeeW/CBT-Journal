//
//  newNotesVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/11/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit

class newNotesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
        textField.layer.shadowRadius = 1
        textField.layer.shadowOpacity = 0.1
        
        for button in buttons{
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.layer.shadowRadius = 1
            button.layer.shadowOpacity = 0.1
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Variables
    //Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var buttons: [UIButton]!
    //Functions
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
