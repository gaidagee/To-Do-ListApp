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

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var animationView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
        setAnimationIcone()
        // Do any additional setup after loading the view.
    }
    @IBAction func signInTapped(_ sender: UIButton) {
        let isFormValid =  validateFields()
        
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
    
    //MARK: - Helpers
    
    private func validateFields() -> Bool{
       var valid = false
        if let emailField = emailTextField.text,
           let passwordField = passwordTextField.text {
            
            if emailField.trimmingCharacters(in: .whitespaces) == "" || passwordField.trimmingCharacters(in: .whitespaces) == "" {
                reportError(title: "Error", message: "Email and Password field must not be empty")
                valid = false
            }
            else {
                valid = true
            }
        }
        return valid
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
    
    func reportError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        
        }
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
    
    }

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
        
        
    }
    
    func setAnimationIcone(){
         let listAnimationView = AnimationView(name: "18332-create-a-shot-list")
        listAnimationView.loopMode = .loop
        listAnimationView.frame = animationView.bounds
        animationView.addSubview(listAnimationView)
        listAnimationView.play()
    }
    
}
