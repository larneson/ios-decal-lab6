//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        
        static let buttonHeight: CGFloat = 40
        static let margin: CGFloat = 10
    }

    // TODO: instantiate the views needed for your project
    var loginViewControllerLabel = UILabel()
    var whiteView = UIView()
    var emailField = UITextField()
    var passwordField = UITextField()
    var loginButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        view.addSubview(loginViewControllerLabel)
        view.addSubview(whiteView)
        
        whiteView.addSubview(emailField)
        whiteView.addSubview(passwordField)
        whiteView.addSubview(loginButton)
        
        
        // TODO: layout your views using frames or AutoLayout
        
        whiteView.backgroundColor = UIColor.white
        
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        let myConstraints = [
            whiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whiteView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                         constant: Constants.margin),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                          constant: -Constants.margin),
            whiteView.heightAnchor.constraint(equalToConstant: Constants.buttonHeight*3 + Constants.margin*4)
        ]
        NSLayoutConstraint.activate(myConstraints)
        
        loginViewControllerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let labelConstraints = [
            loginViewControllerLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            loginViewControllerLabel.bottomAnchor.constraint(equalTo: whiteView.topAnchor, constant: -8),
            loginViewControllerLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            loginViewControllerLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        loginViewControllerLabel.text = "Login View Controller"
        loginViewControllerLabel.textColor = UIColor.white
        loginViewControllerLabel.textAlignment = .center
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        let emailConstraints = [
            emailField.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: Constants.margin),
            emailField.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor,
                                               constant: Constants.margin),
            emailField.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor,
                                                constant: -Constants.margin),
            emailField.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)

        ]
        NSLayoutConstraint.activate(emailConstraints)
        
        emailField.placeholder = "berkeley.edu email"
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordConstraints = [
            passwordField.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Constants.margin),
            passwordField.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor,
                                                constant: Constants.margin),
            passwordField.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor,
                                                 constant: -Constants.margin),
            passwordField.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
            
        ]

        NSLayoutConstraint.activate(passwordConstraints)
        passwordField.placeholder = "password"
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let loginButtonConstraints = [
            loginButton.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Constants.margin),
            loginButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor,
                                                   constant: Constants.margin),
            loginButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor,
                                                    constant: -Constants.margin),
            loginButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
            
        ]
        
        NSLayoutConstraint.activate(loginButtonConstraints)
        loginButton.backgroundColor = Constants.backgroundColor
        loginButton.setTitle("Submit", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchDown)
    }
    
    // TODO: create an IBAction for your login button
    
    @IBAction func loginButtonClicked(sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        authenticateUser(username: email, password: password)
    }
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
