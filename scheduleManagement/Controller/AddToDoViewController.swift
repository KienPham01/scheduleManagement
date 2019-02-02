 //
//  AddToDoViewController.swift
//  scheduleManagement
//
//  Created by Kien on 2/1/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController {
    var managerContext:NSManagedObjectContext!

    @IBOutlet var textView: UITextView!
    
    @IBOutlet var done: UIButton!
    
    @IBOutlet var bottomContraint:NSLayoutConstraint!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        
        guard let title = textView.text,!title.isEmpty else {
            return
        }
        let todo = Todo(context: managerContext)
        todo.title = title
        todo.priority = Int16(segmentedControl.selectedSegmentIndex)
        todo.date = Date()
        do{
            try managerContext.save()
            dismiss(animated: true, completion: nil)

        }
        catch{
            
            print("Error saving todo:\(error)")
        }
//        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .didReceiveData, object: nil)

   
//        textView.becomeFirstResponder()
        
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
 
 extension AddToDoViewController:UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if done.isHidden{
            textView.text.removeAll()
            textView.textColor = .white
            done.isHidden = false
            
            UIView.animate(withDuration: 0.3){
                self.view.layoutIfNeeded()
            }
            
        }
    }
 }
