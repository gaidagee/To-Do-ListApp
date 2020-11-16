//
//  TestViewController.swift
//  ToDoApp
//
//  Created by Gaida  on 05/11/2020.
//

import UIKit
import Firebase

import Lottie
class SignIn: UIViewController {
    var TasksManagerList : TaskManager!

    
    @IBOutlet var backGround: UIView!
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var signUpStack: UIStackView!
    @IBOutlet var loginStack: UIStackView!
    
    
    //sign in
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    //sign up
    @IBOutlet var signUpEmailField: UITextField!
    @IBOutlet var signUpPasswordField: UITextField!
    
    
    
    @IBOutlet var animationView: UIView!
    
    
    @IBOutlet var signUpTapped: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
        setAnimationIcone()
    }
    
    
    
    @IBAction func registrationType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            headerLabel.text = "Sign In"
            loginStack.isHidden = false
            signUpStack.isHidden = true
        case 1:
            headerLabel.text = "Sign Up"
            loginStack.isHidden = true
            signUpStack.isHidden = false
        default:
            print("none")
        }
    }
    
    @IBAction func signUPTapped(_ sender: Any) {
        let isFormValid =  validateFields(field: signUpEmailField, field2: signUpPasswordField)
        switch isFormValid {
        case true:
            signUp()
        case false:
            reportError(title: "Error", message: "Form not valid")
        }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        let isFormValid =  validateFields(field: emailTextField, field2: passwordTextField)
        
        switch isFormValid {
        case true:
            signIn()
        case false:
            reportError(title: "Error", message: "Form not valid")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let vc = segue.destination as! ListsViewController
            vc.TasksManagerList = TasksManagerList
        }
    }
    
   
    private func signIn() {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        Auth.auth().signIn(withEmail: email, password: password){
            (result, error) in
            
            if error != nil {
                self.reportError(title: "Error", message: "Error in sign in")
                
            } else {
                self.performSegue(withIdentifier: "login", sender: nil)

            }
        }
    }
    
    private func signUp() {
        let email = signUpEmailField.text!.trimmingCharacters(in: .whitespaces)
        let password = signUpPasswordField.text!.trimmingCharacters(in: .whitespaces)
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (result, error) in
            
            if error != nil {
                self.reportError(title: "Error", message: "Error in signing up")
                
            } else {
                let db = Firestore.firestore()
                db.collection("Users").addDocument(data:
                                                    ["email" : email,
                                                   "pass" : password,
                                                   "id" : result!.user.uid]) {
                    (error) in
                    if error != nil {
                        self.reportError(title: "Error", message: "Error in sign up")
                    } else {
                        self.performSegue(withIdentifier: "login", sender: nil)

                    }
                }

            }
        }
        
    }
    
    //MARK: - Helpers
    
    private func validateFields(field: UITextField, field2: UITextField) -> Bool{
       var valid = false
        if let emailField = field.text,
           let passField = field2.text {
            
            if emailField.trimmingCharacters(in: .whitespaces) == "" || passField.trimmingCharacters(in: .whitespaces) == "" {
                reportError(title: "Error", message: "Email and Password field must not be empty")
                valid = false
            }
            else {
                valid = true
            }
        }
        return valid
    }
    
//    func reportErrorSignup(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            alert.dismiss(animated: true, completion: nil)
//
//        }
//                alert.addAction(okAction)
//                present(alert, animated: true, completion: nil)
//
//    }

}

extension SignIn {
    
    func ConfigureUI(){
        view.backgroundColor = .darkGreen
        emailTextField.backgroundColor = .offWhite
        emailTextField.placeholder = "Enter your email"
        passwordTextField.backgroundColor = .offWhite
        passwordTextField.placeholder = "**********"

        signInButton.setTitleColor(.offWhite, for: .normal)
        signInButton.allRoundedConrners(radius: 10)
        signInButton.backgroundColor = .peachyPink
        
        signUpEmailField.backgroundColor = .offWhite
        signUpEmailField.placeholder = "Enter your email"
        signUpPasswordField.backgroundColor = .offWhite
        signUpPasswordField.placeholder = "**********"

        signUpTapped.setTitleColor(.offWhite, for: .normal)
        signUpTapped.allRoundedConrners(radius: 10)
        signUpTapped.backgroundColor = .peachyPink
        
        backGround.allRoundedConrners()
        
    }
    
    func setAnimationIcone(){
         let listAnimationView = AnimationView(name: "18332-create-a-shot-list")
        listAnimationView.loopMode = .loop
        listAnimationView.frame = animationView.bounds
        animationView.addSubview(listAnimationView)
        listAnimationView.play()
    }
    
}
