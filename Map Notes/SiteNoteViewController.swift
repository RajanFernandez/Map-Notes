//
//  SiteNoteViewController.swift
//  Map Notes
//
//  Created by Rajan Fernandez on 9/12/15.
//  Copyright © 2015 Rajan Fernandez. All rights reserved.
//

import UIKit

class SiteNoteViewController : UIViewController {
    
    @IBOutlet var textView: UITextView!
    var textViewDelegate: UITextViewDelegate? = nil
    var existingNote: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = textViewDelegate
        textView.text = existingNote
        textView.becomeFirstResponder()

    }
    
    @IBAction func doneButtonPressed() {
        
        textView.endEditing(true)
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
