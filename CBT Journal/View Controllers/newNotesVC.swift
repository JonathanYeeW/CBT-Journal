//
//  newNotesVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/11/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
class newNotesVC: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        //MARK: Below for UI/UX
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 15
        for button in buttons{
            //MARK: Commented code below for giving buttons shadows. Decided not to
            // use it last minute, but wanted to keep the code in event I want to later
            //button.layer.shadowColor = UIColor.gray.cgColor
            //button.layer.shadowOffset = CGSize(width: 2, height: 2)
            //button.layer.shadowRadius = 1
            //button.layer.shadowOpacity = 0.1
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
        }
    }//End viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        print("## viewWillAppear ##")
        //MARK: Below code, that when the VC loads,
        // based on what the attributes of the pageObject is,
        // changes the color of the buttons.
        if pageObject?.event != "" {
            eventButtonLabel.backgroundColor = UIColor.white
        }
        if pageObject?.initialThoughts != "" {
            initialThoughtsButtonLabel.backgroundColor = UIColor.white
        }
        if pageObject?.initialFeelings != "" {
            initialFeelingButtonLabel.backgroundColor = UIColor.white
        }
        if pageObject?.thoughts != "" {
            newThoughtsButtonLabel.backgroundColor = UIColor.white
        }
        if pageObject?.feelings != "" {
            newFeelingsButtonLabel.backgroundColor = UIColor.white
        }
        if pageObject?.summary != "" {
            summaryButtonLabel.backgroundColor = UIColor.white
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }//End didReceiveMemoryWarning()
    
    //Variables
    let objectManager = ObjectManager()
    let pageManager = PageManager()
    var pageObject: Page?
    var typeSwitch = 0
    
    //Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var eventButtonLabel: UIButton!
    @IBOutlet weak var initialThoughtsButtonLabel: UIButton!
    @IBOutlet weak var initialFeelingButtonLabel: UIButton!
    @IBOutlet weak var newThoughtsButtonLabel: UIButton!
    @IBOutlet weak var newFeelingsButtonLabel: UIButton!
    @IBOutlet weak var summaryButtonLabel: UIButton!
    
    //MARK: buttons is the collect to be used for shadows
    @IBOutlet var buttons: [UIButton]!
    @IBAction func unwindFromInputVCtonewNotesVC(segue: UIStoryboardSegue){
        print("@@ unwindFromInputVCtonewNotesVC @@")
        let source = segue.source as! InputVC
        if source.typeSwitch == 0 {
            print("> The Event")
            pageObject?.event = source.textView.text
        } else if source.typeSwitch == 1 {
            print("> Initial Thoughts")
            pageObject?.initialThoughts = source.textView.text
        } else if source.typeSwitch == 2 {
            print("> Initial Feelings")
            pageObject?.initialFeelings = source.textView.text
        } else if source.typeSwitch == 3 {
            print("> New Thoughts")
            pageObject?.thoughts = source.textView.text
        } else if source.typeSwitch == 4 {
            print("> New Feelings")
            pageObject?.feelings = source.textView.text
        } else if source.typeSwitch == 5 {
            print("> Summary")
            pageObject?.summary = source.textView.text
        }
        pageObject?.title = source.textField.text
        objectManager.saveToDatabase()
    }
    
    //MARK: The IBActions below are for the corresponding buttons
    // on the Input NotesVC
    @IBAction func eventButtonPressed(_ sender: UIButton) {
        print("@@ eventButtonPressed @@")
        typeSwitch = 0
        performSegue(withIdentifier: "segueToInputVC", sender: nil)
    }
    
    @IBAction func initialThoughtsPressed(_ sender: UIButton) {
        print("@@ initialThoughtsPressed @@")
        typeSwitch = 1
        performSegue(withIdentifier: "segueToInputVC", sender: nil)
    }
    
    @IBAction func initalFeelingsPressed(_ sender: UIButton) {
        print("@@ initialFeelingsPressed @@")
        typeSwitch = 2
        performSegue(withIdentifier: "segueToInputVC", sender: nil)
    }
    
    @IBAction func thoughtsPressed(_ sender: UIButton) {
        print("@@ thoughtsPressed @@")
        typeSwitch = 3
        performSegue(withIdentifier: "segueToInputVC", sender: nil)
    }
    
    @IBAction func feelingsPressed(_ sender: UIButton) {
        print("@@ feelingsPressed @@")
        typeSwitch = 4
        performSegue(withIdentifier: "segueToInputVC", sender: nil)
    }
    
    @IBAction func summaryPressed(_ sender: UIButton) {
        print("@@ summaryPressed @@")
        typeSwitch = 5
        performSegue(withIdentifier: "segueToInputVC", sender: nil)
    }
    
    //Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInputVC" {
            //MARK: Preparing Segue, after the Add New Entry... was pressed
            print("> segueToInputVC")
            let controller = segue.destination as! InputVC
            controller.pageObject = pageObject
            controller.typeSwitch = typeSwitch
        }
    }//End prepare()
    
    //MARK: Below is code for the textField Delegate allowing the user to hit
    // return or touch outside the bounds of the keyboard to end editing.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }//End touchesBegan()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("## textFieldShouldReturn ##")
        pageManager.updateTitle(newString: textField.text!, pageObject: pageObject!)
        textField.resignFirstResponder()
        return true
    }//End textFieldShouldReturn()
    
    
}//End Class
