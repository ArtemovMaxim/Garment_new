//
//  AuthViewController.swift
//  Garment
//
//  Created by Максим Артемов on 06.10.2021.
//

import UIKit
import Firebase



class AuthViewController: UIViewController {

        //    MARK: vars
        var segueToGlobalIdentifier = "toGlobalMenuSegue"
        var segueToTimeLineIdentifier = "toTL"
        
        //MARK: Outlets
        
        //    IBOutlets
        @IBOutlet weak var emailField: UITextField!
        @IBOutlet weak var statusLabel: UILabel!
        @IBOutlet weak var passwordField: UITextField!
        @IBOutlet weak var nameField: UITextField!
        @IBOutlet weak var logoutButton: UIButton!
        @IBOutlet weak var choiceRegistrationRole: UISegmentedControl!
        @IBOutlet weak var logInButton: UIButton!
        @IBOutlet weak var questionReg: UILabel!
        @IBOutlet weak var questionEnterButton: UIButton!
        @IBOutlet weak var headerLabel: UILabel!
        
        //    IBActions
        @IBAction func enterButton(_ sender: UIButton) {
            
            if questionEnterButton.titleLabel?.text == "Войти" {
                loginStateFields()
                
            } else if questionEnterButton.titleLabel?.text == "Регистрация" {
                if choiceRegistrationRole.selectedSegmentIndex == 0 {
                    storeRegistrationStateFields()
                } else if choiceRegistrationRole.selectedSegmentIndex == 1 {
                    userRegistrationStateFields()
                }
                questionEnterButton.setTitle("Войти", for: .normal)
                questionReg.text = "Есть аккаунт?"
                nameField.isHidden = false
            }
        }
        
        @IBAction func choiceRegistrationRole(_ sender: UISegmentedControl) {
            
            if sender.selectedSegmentIndex == 0 {
                storeRegistrationStateFields()
                signOutFireBase()
                clearAllFields()
                AuthAccaunt.authProfile = .store
                
            } else if sender.selectedSegmentIndex == 1 {
                userRegistrationStateFields()
                signOutFireBase()
                clearAllFields()
                AuthAccaunt.authProfile = .user
            }
        }
        
        @IBAction func logoutButton(_ sender: Any) {
            AuthAccaunt.authProfile = .nonAuth
            
            signOutFireBase()
            clearAllFields()
        }
        
        
        @IBAction func logInButton(_ sender: Any) {
            AuthAccaunt.nameStore = emailField.text!
            
            self.reloadInputViews()
            
            if choiceRegistrationRole.selectedSegmentIndex == 0 {
                signOutFireBase()
                
                // закладка магазин, регистрация
                
                if questionEnterButton.titleLabel?.text == "Войти" {
                    
                    
                    
                    Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!) {  (result, error) in
                        if error == nil {
                            if let result = result {
                                print(result.user.uid)
                                
                                let db = Firestore.firestore()
                                
                                db.collection("stores").document(result.user.uid).setData([
                                    "nameStore": self.nameField.text!,
                                    "emailStore": self.emailField.text!,
                                    "passwordStore": self.passwordField.text!,
                                    "idStore": result.user.uid
                                ]) { (error) in
                                    if error != nil {
                                        print(error.debugDescription)
                                    }
                                }
                                
                                AuthAccaunt.statusLog = .loged
                                self.statusLabel.text = "Зарегистрирован"
                                
                                self.showSettingsVC()
                                
                            }
                        } else { self.customAlert(text: "Пароль неверный") }
                        self.clearAllFields()

                    }
                    
                    
                    
                    // закладка магазин, вход
                } else if questionEnterButton.titleLabel?.text == "Регистрация" {
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                        if error == nil {
                            if let result = result {
                                print(result.user.uid)
                                
                                AuthAccaunt.statusLog = .loged
                                self.statusLabel.text = "Зарегистрирован"
                                
                                self.showSettingsVC()


                            }
                        } else {
                            self.customAlert(text: "Неверный пароль")
                            self.clearAllFields()

                        }
                    }
                }
                
            } else if choiceRegistrationRole.selectedSegmentIndex == 1 {
                signOutFireBase()
                
                // закладка юзер, регистрация
                
                if questionEnterButton.titleLabel?.text == "Войти" {
                    Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!) {  (result, error) in
                        if error == nil {
                            if let result = result {
                                print(result.user.uid)
                                
                                let db = Firestore.firestore()
                                db.collection("users").addDocument(data: [
                                    "nameUser": self.nameField.text!,
                                    "emailUser": self.emailField.text!,
                                    "passwordUser": self.passwordField.text!,
                                    "idUser": result.user.uid
                                ]) { (error) in
                                    if error != nil {
                                        fatalError("Error saving store to database")
                                    }
                                }
                                
                                AuthAccaunt.statusLog = .loged
                                self.statusLabel.text = "Зарегистрирован"
                                
                                self.showTimeLineVC()
                                
                            }
                        } else { self.customAlert(text: "Неверный пароль")
 }
                        self.clearAllFields()

                    }
                    
                    // закладка юзер, вход
                    
                } else if questionEnterButton.titleLabel?.text == "Регистрация" {
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                        if error == nil {
                            if let result = result {
                                print(result.user.uid)
                                
                                AuthAccaunt.statusLog = .loged
                                self.statusLabel.text = "Зарегистрирован"
                                
                                self.showTimeLineVC()
                                
                            }
                        } else {
                            self.customAlert(text: "Неверный пароль")
                            self.clearAllFields()
                        }
                    }
                }
            }
        }
        
        
        //MARK: custom functions
    
    func showGlobalMenuVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
//        self.navigationController?.visibleViewController!.removeFromParent()
        self.navigationController?.pushViewController(globalMenu, animated: true)
    }
    
    func showTimeLineVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timeLine = storyboard.instantiateViewController(withIdentifier: "TimeLineCollectionViewController") as! TimeLineCollectionViewController
//        self.navigationController?.visibleViewController!.removeFromParent()

        self.navigationController?.pushViewController(timeLine, animated: true)

    }
    
    func showSettingsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settings = storyboard.instantiateViewController(withIdentifier: "StoreSettingsTableViewController") as! StoreSettingsTableViewController
//        self.navigationController?.visibleViewController!.removeFromParent()

        self.navigationController?.pushViewController(settings, animated: true)

    }
    
    
    func customAlert(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Исправить", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
        
        // проверка на заполнение полей
        func alertControlFillingFields3(field1: UITextField, field2: UITextField, field3: UITextField) -> Bool {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            let action = UIAlertAction(title: "Добавить", style: .default, handler: nil)
            alert.addAction(action)
            
            
            if field1.text == "" || field2.text == "" || field3.text == "" {
                self.present(alert, animated: true, completion: nil)
                return false
            } else {
                return true
                
            }
        }
        
        func alertControlFillingFields2(field1: UITextField, field2: UITextField) {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            let action = UIAlertAction(title: "Добавить", style: .default, handler: nil)
            alert.addAction(action)
            
            
            if field1.text == "" || field2.text == "" {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        // состояние полей для процедуры авторизации (не регистрации)
        func loginStateFields() {
            nameField.isHidden = true
            //        nameField.isEnabled = false
            emailField.placeholder = "введите e-mail"
            passwordField.placeholder = "введите пароль"
            logInButton.setTitle(" Войти ", for: .normal)
            questionReg.text = "Нет аккаунта?"
            questionEnterButton.setTitle("Регистрация", for: .normal)
            headerLabel.isHidden = true
        }
        
        // состояние полей для процедуры регистрации магазина
        func storeRegistrationStateFields() {
            nameField.placeholder = "введите название магазина"
            emailField.placeholder = "введите e-mail магазина"
            passwordField.placeholder = "придумайте пароль (не меннее 6 знаков)"
            logInButton.setTitle(" Регистрация магазина ", for: .normal)
        }
        
        // состояние полей для процедуры регистрации покупателя
        func userRegistrationStateFields() {
            nameField.placeholder = "введите название своего аккаунта"
            emailField.placeholder = "введите свой e-mail"
            passwordField.placeholder = "придумайте пароль (не меннее 6 знаков)"
            logInButton.setTitle(" Регистрация покупателя ", for: .normal)
        }
        
        // обнуление полей
        func clearAllFields() {
            nameField.text = ""
            emailField.text = ""
            passwordField.text = ""
        }
        
        func signOutFireBase() {
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }
        
        //    func signInFireBase(email: String, password: String) {
        //        Auth.auth().signIn(withEmail: email, password: password, completion: <#T##((AuthDataResult?, Error?) -> Void)?##((AuthDataResult?, Error?) -> Void)?##(AuthDataResult?, Error?) -> Void#>)
        //    }
        
        
        //MARK: стандартные функции
        
        
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.

        
        //скрытие клавиатуры
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
}
