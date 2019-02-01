 //
//  AddToDoViewController.swift
//  scheduleManagement
//
//  Created by Kien on 2/1/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    @IBOutlet var done: UIButton!
    
    @IBOutlet var bottomContraint:NSLayoutConstraint!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        textView.becomeFirstResponder()
        
//        NotificationCenter.default.addObserver(self,
//                            selector: #selector(keyboardWillShow(with:)),
//                        name:.UIKeyboardWillShow,
//                        object: nil)

        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillShow(with notification:Notification){
        let key = "UIKeyboardFrameEndUserInfoKey"

        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height+16
        bottomContraint.constant = keyboardHeight

        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
