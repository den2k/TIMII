//
//  LoginScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 7/27/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Firebase
import Layout

class LoginScreen: UIViewController, LayoutLoading, UITextFieldDelegate
{
    // TODO: 7.30.18 - refactor keyboard related code to a separate component/system
    var isKeyboardVisible = false
    
    // Login Properties
    @IBOutlet var emailTextField : UITextField?
    @IBOutlet var passwordTextField : UITextField?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        // 7.30.18 - Temporary code for testing XML views. Works.
//        let email = UITextField()     // replaces emailTextField?.text
//        let password = UITextField()  // replaces passwordTextField?.text
//        email.text = "ellie@eaton.com"
//        password.text = "12345"
        
        self.loadLayout(
            named: "LoginScreen.xml",
            state:[
                "isKeyboardVisible": isKeyboardVisible,
                "email": emailTextField?.text as Any,
                "password": passwordTextField?.text as Any
            ]
        )
    }
    
    @objc func createAccountScreen()
    {
        // TODO: 7.30.18 - need to convert from present to dismiss to show createAccountScreen
        let screen = CreateAccountScreen()
        present(screen, animated: true, completion: nil)
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

    // Update screen when varibles change
    private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.layoutNode?.setState([
            "isKeyboardVisible": isKeyboardVisible
        ])
    }
    
    // Handle login request and authentication with Firebase
    @objc func handleLogin() {
        guard let email = emailTextField?.text, let password = passwordTextField?.text else
        {
            print("Form is not valid.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in

            if error != nil {
                print(error ?? "Error")
                return
            }
            self.dismiss(animated: true, completion: nil)
        } )

    }
}

//        view.addSubview(inputsContainerView)
//        view.addSubview(loginRegisterButton)
//        view.addSubview(profileImageView)
//        view.addSubview(loginRegisterSegmentControl)
//        setupInputsContainerView()
//        setupLoginRegisterButton()
//        setupProfileImageView()
//        setupLoginRegisterSegmentControl()
    
//    // The lazy var initialization allows self references inside a closure block
//    // EP 5 - 3:20
//    lazy var profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "time_logo")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill  // show image with correct ratio
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
//        imageView.addGestureRecognizer(tap)
//        imageView.isUserInteractionEnabled = true
//        return imageView
//    }()
//    
//    @objc func handleSelectProfileImageView() {
//        let picker = UIImagePickerController()
//        
//        picker.delegate = self  // must define UIImagePickerControllerDelegate AND UINavigationControllerDelegate
//        picker.allowsEditing = true
//        
//        present(picker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        // EP5 - 13:50
//        
//        var selectedImageFromPicker: UIImage?
//        
//        
//        // Need to cast originalImage using as? UIImage or else the .size reference will not work
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage  {
//            selectedImageFromPicker = editedImage
//            //print(editedImage.size)
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            selectedImageFromPicker = originalImage
//            //            print(originalImage.size)
//        }
//        
//        if let selectedImage = selectedImageFromPicker {
//            profileImageView.image = selectedImage
//        }
//        
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("cancelled picker")
//        dismiss(animated: true, completion: nil)
//    }
//    
//    let loginRegisterSegmentControl: UISegmentedControl = {
//        let sc = UISegmentedControl(items: ["Login", "Register"])
//        sc.translatesAutoresizingMaskIntoConstraints = false
//        sc.tintColor = UIColor.white
//        sc.selectedSegmentIndex = 1     // Register selected
//        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
//        return sc
//    }()
//    
//    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
//    
//    func setupInputsContainerView() {
//        // need x, y, width, height constraints
//        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
//        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
//        inputsContainerViewHeightAnchor?.isActive = true
//        inputsContainerView.addSubview(nameTextField)
//        inputsContainerView.addSubview(nameSeparatorView)
//        inputsContainerView.addSubview(emailTextField)
//        inputsContainerView.addSubview(emailSeparatorView)
//        inputsContainerView.addSubview(passwordTextField)
//        setupNameTextField()
//        setupNameSeparatorView()
//        setupEmailTextField()
//        setupEmailSeparatorView()
//        setupPasswordTextField()
//    }
//    
//    let nameTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Name"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
//    
//    var nameTextFieldHeightAnchor: NSLayoutConstraint?
//    
//    let emailTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Email"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
//    
//    var emailTextFieldHeightAnchor: NSLayoutConstraint?
//    
//
//    let passwordTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Password"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.isSecureTextEntry = true
//        return tf
//    }()
//    
//    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
//    
//    var loginRegisterButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
//        button.setTitle("Register", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.layer.cornerRadius = 5
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        
//        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
//        
//        return button
//        
//    }()
//    
//    @objc func handleLoginRegister() {
//        
//        if loginRegisterSegmentControl.selectedSegmentIndex == 0 {
//            handleLogin()
//        } else {
//            handleRegister()
//        }
//    }
//    
//    func handleLogin() {
//        guard let email = emailTextField.text, let password = passwordTextField.text else {
//            print("Form is not valid.")
//            return
//        }
//        
//        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
//            
//            if error != nil {
//                print(error ?? "Error")
//                return
//            }
////            self.messagesController?.fetchUserAndSetupNavBarTitle()
//            self.dismiss(animated: true, completion: nil)
//        } )
//        
//    }
//    
//    @objc func handleRegister() {
//        
//        // Best Practice - use guard statements to conduct nil testing of user input before pushing them to DB
//        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
//            print("Form is not valid.")
//            return
//        }
//        
//        // Firebase Authentication Auth
//        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: Firebase.User?, error) in
//            if error != nil {
//                print(error ?? "Error")
//                return
//            }
//            
//            guard let uid = user?.uid else {
//                return
//            }
//            
//            // NSUUID provides a universally unique 128-bit value
//            let imageName = NSUUID().uuidString
//            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
//            
//            // Replaced PNG call with JPEG call which has compression build in.
//            // The UIImageJPEG.... 0.1 compresses the image to 10% of original size
//            if let profileImageView = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImageView, 0.1) {
//                
//                // this line must force unwrap an optional image with the ! command.
//                // the line above checks first for an image before using it in the JPEG....call
//                //            if let uploadData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1) {
//                //            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
//                
//                storageRef.putData(uploadData, metadata: nil, completion: {(metadata, error) in
//                    
//                    if error != nil {
//                        print(error ?? "error")
//                        return
//                    }
//                    
//                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
//                        
//                        let ref = Database.database().reference()
//                        let usersReference = ref.child("users").child(uid)
//                        let values = ["name": name, "email": email, "password": password, "profileImageURL": profileImageURL]
//                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
//                            if err != nil {
//                                print(err ?? "Err")
//                                return
//                            }
//                            // self.messagesController?.fetchUserAndSetupNavBarTitle()  - avoid 1 firebase call
//                            // use the statement below instead
//                            // EP7 - 10.55
//                            self.messagesController?.fetchUserAndSetupNavBarTitle()
//                            self.dismiss(animated: true, completion: nil)
//                        })
//                    }
//                })
//            }
//        })
//    }
//    
//}
//
//extension UIColor {
//    
//    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
//        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
//    }

