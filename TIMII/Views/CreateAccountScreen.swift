//  Created by Daddy on 7/28/18.
//  Copyright © 2018 Autonomii. All rights reserved.

import UIKit
import Layout

class CreateAccountScreen: UIViewController, LayoutLoading
{    
    var isKeyboardVisible = false
    
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
}
