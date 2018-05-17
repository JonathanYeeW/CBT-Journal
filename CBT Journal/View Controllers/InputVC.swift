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
    let Kakashi = PageManager()
    var pageObject: Page?
    var typeSwitch = 0    
    var descriptionDictionary = [0: "Describe in 1-3 sentences what you were doing or thinking about when you started to feel these emotions/think these thoughts", 1: "Describe your initial thoughts. Write phrases in terms of 'I think' not 'I feel'.", 2: "What feelings/physical reactions are you experiencing?", 3: "Reread and reflect on your initial thoughts. Where, if at all, are your thoughts distorted? Why are they distorted? Is there another way to look at the event?", 4: "Now that you've reflected on your thoughts, how are you feeling?", 5: "What is the big takeaway from this experience? Why do you think you had this response? How do you want to respond to these thoughts in the future?"]
    
    
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("## textFieldShouldReturn ##")
        Kakashi.updateTitle(newString: textField.text!, pageObject: pageObject!)
        textField.resignFirstResponder()
        return true
    }
    
}//End Class
