//  Created by Daddy on 7/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.

import UIKit
import Layout
import Firebase

class CreateAccountScreen: UIViewController, LayoutLoading
{    
    var isKeyboardVisible = false
    
    // Create Account Properties
    @IBOutlet var emailTextField : UITextField?
    @IBOutlet var passwordTextField : UITextField?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        self.loadLayout(
            named: "CreateAccountScreen.xml",
            state:[
                "isKeyboardVisible": isKeyboardVisible
            ]
        )
    }
    
    @objc func loginScreen()
    {   // dismiss to LoginScreen
        dismiss(animated: true, completion: nil)
    }
    
    // Dismiss the keyboard after RETURN press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }
    
    @objc func keyboardWillShow(notification: Notification)
    {
        isKeyboardVisible = true
        updateView()
    }
    
    @objc func keyboardWillHide(notification: Notification)
    {
        isKeyboardVisible = false
        updateView()
    }
    
    private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.layoutNode?.setState([
            "isKeyboardVisible": isKeyboardVisible
        ])
    }
    
    @objc func handleCreateAccount()
    {
        guard let email = emailTextField?.text, let password = passwordTextField?.text else
        {
            print("Form is not valid. Unable to create account.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion:
        {(user, error) in
            if error != nil
            {
                print(error ?? "Error creating user.")
                return
            }
            // TODO: 8.5.18 - need to dismiss to Main screen and not just LoginScreen
            // DONE: https://stackoverflow.com/questions/3224328/how-to-dismiss-2-modal-view-controllers-in-succession/44583711#44583711
//            self.dismiss(animated: true, completion: nil)
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            
        })
    }
}
