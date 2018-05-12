//
//  InputVC.swift
//  CBT Journal
//
//  Created by Jonathan Yee on 5/1/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit

class InputVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        print(""); print("xX_ InputVC _Xx"); print("## viewDidLoad ##")
        super.viewDidLoad()
        //MARK: Below for UI/UX
        textView.delegate = self
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        //MARK: Below sets the filler in the inputs based on the typeSwitch
        // that is being sent over from the NotesVC
        if typeSwitch == 0 {
            print("> The Event")
            textView.text = pageObject?.event
        } else if typeSwitch == 1 {
            print("> Initial Thoughts")
            textView.text = pageObject?.initialThoughts
        } else if typeSwitch == 2 {
            print("> Initial Feelings")
            textView.text = pageObject?.initialFeelings
        } else if typeSwitch == 3 {
            print("> New Thoughts")
            if pageObject?.thoughts == "" {
                textView.text = pageObject?.initialThoughts
            } else {
                textView.text = pageObject?.thoughts
            }
        } else if typeSwitch == 4 {
            print("> New Feelings")
            textView.text = pageObject?.feelings
        } else if typeSwitch == 5 {
            print("> Summary")
            textView.text = pageObject?.summary
        }
        descriptionLabel.text = descriptionDictionary[typeSwitch]
        if pageObject?.title == "Topic" {
            textField.text = ""
        } else {
            textField.text = pageObject?.title
        }
    }//End viewDidLoad()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }//End didReceiveMemoryWarning()
    
    //Variables
    var pageObject: Page?
    var typeSwitch = 0
    var descriptionDictionary = [0: "Describe in 1-3 sentences what event triggered your emotional response.", 1: "Describe your inital thoughts to the event. Try to write phrases in terms of 'I think...' rather than 'I feel that...'", 2: "What feelings/physical reactions did you/are you experiencing?", 3: "Reflecting on your initial thoughts of the event, read over your descriptions and try to recognize any distorted thought patterns and respond to them. Why are they distorted? What are some other ways to look at it?", 4: "How are you feeling now?", 5: "What about you can you take away from this experience? What do you want to work on? Why do you think you had this response? What do you want to improve about yourself or have you accomplished something today?"]
    
    //Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        print("@@ cancelButtonPressed @@")
        dismiss(animated: true, completion: nil)
    }//End cancelButtonPressed()
    
    //Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("## touchesBegan ##")
        self.textView.endEditing(true)
        self.textField.endEditing(true)
    }//End touchesBegan()
}//End Class
