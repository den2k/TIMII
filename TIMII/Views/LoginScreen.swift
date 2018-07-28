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

class LoginScreen: UIViewController, LayoutLoading
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLayout(
            named: "LoginScreen.xml"
        )
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
//    func setupProfileImageView() {
//        // need x, y, width, height constraints
//        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentControl.topAnchor, constant: -12).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
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
//    @objc func handleLoginRegisterChange() {
//        let title = loginRegisterSegmentControl.titleForSegment(at: loginRegisterSegmentControl.selectedSegmentIndex)
//        loginRegisterButton.setTitle(title, for: .normal)
//        
//        // Change height of inputContainerView
//        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 100 : 150
//        
//        // Change height of nameTextField
//        // nameTextFieldHeightAnchor?.multiplier = 0    // multiplier is a get-only property so the following code is needed
//        nameTextFieldHeightAnchor?.isActive = false
//        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 0 : 1/3)
//        nameTextFieldHeightAnchor?.isActive = true
//        
//        // Change height of emailTextField
//        // emailTextFieldHeightAnchor?.multiplier = 0    // multiplier is a get-only property so the following code is needed
//        emailTextFieldHeightAnchor?.isActive = false
//        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
//        emailTextFieldHeightAnchor?.isActive = true
//        
//        // Change height of passwordTextField
//        // passwordTextFieldHeightAnchor?.multiplier = 0    // multiplier is a get-only property so the following code is needed
//        passwordTextFieldHeightAnchor?.isActive = false
//        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
//        passwordTextFieldHeightAnchor?.isActive = true
//        
//    }
//    
//    func setupLoginRegisterSegmentControl() {
//        // need x, y, width, height constraints
//        loginRegisterSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        loginRegisterSegmentControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
//        loginRegisterSegmentControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, multiplier: 1.0).isActive = true
//        loginRegisterSegmentControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
//    }
//    
//    let inputsContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 5
//        view.layer.masksToBounds = true
//        return view
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
//    func setupNameTextField() {
//        // need x, y, width, height constraints
//        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
//        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
//        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -12).isActive = true
//        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
//        nameTextFieldHeightAnchor?.isActive = true
//    }
//    
//    let nameSeparatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    func setupNameSeparatorView() {
//        // need x, y, width, height constraints
//        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
//        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
//        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
//        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
//    }
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
//    func setupEmailTextField() {
//        // need x, y, width, height constraints
//        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
//        emailTextField.topAnchor.constraint(equalTo: nameSeparatorView.bottomAnchor).isActive = true
//        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -12).isActive = true
//        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
//        emailTextFieldHeightAnchor?.isActive = true
//    }
//    
//    let emailSeparatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    func setupEmailSeparatorView() {
//        // need x, y, width, height constraints
//        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
//        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
//        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
//        emailSeparatorView .heightAnchor.constraint(equalToConstant: 1).isActive = true
//    }
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
//    func setupPasswordTextField() {
//        // need x, y, width, height constraints
//        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
//        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
//        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: -12).isActive = true
//        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
//        passwordTextFieldHeightAnchor?.isActive = true
//    }
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
//    func setupLoginRegisterButton() {
//        // need x, y, width, height constraints
//        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
//        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
//        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//    
//}
//
//extension UIColor {
//    
//    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
//        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
//    }

