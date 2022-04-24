//
//  AuthViewController.swift
//  Garment
//
//  Created by Максим Артемов on 06.10.2021.
//

import UIKit
import Firebase



class AuthViewController: UIViewController {
    
    // варианты ошибок
    enum alertEnumAuth: String {
        
        case noName = " название магазина"
        case noEmail = " e-mail / логин "
        case noPassword = " пароль для входа"
    }
    
    var alerts: String = "" // массив ошибок заполнения полей
    
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
                showAlert()
                
                Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!) {  (result, error) in
                    if error == nil {
                        if let result = result {
                            
                            let db = Firestore.firestore()
                            
                            db.collection("stores").document(self.emailField.text!).setData([
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
                            
                            // залогинивание нового магазина
                            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!)
                            AuthAccaunt.authProfile = .store
                            
                            
                            
                            self.showGlobalMenuVC()
                            
                            // удаление экрана авторизации из стека
                            var navigationControllers = self.navigationController?.viewControllers
                            navigationControllers?.remove(at: 0)
                            self.navigationController?.viewControllers = navigationControllers!
                        }
                    } else { self.customAlert(text: "Пароль неверный") }
                    self.clearAllFields()
                    
                }
                
                
                
                
                
                // закладка магазин, вход
            } else if questionEnterButton.titleLabel?.text == "Регистрация" {
                AuthAccaunt.authProfile = .store
                showAlert()
                
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                    if error == nil {
                        if result != nil {
                            
                            AuthAccaunt.statusLog = .loged
                            self.statusLabel.text = "Зарегистрирован"
                            
                            AuthAccaunt.nameStore = self.emailField.text!
                            //  подгрузка свойств магазина
                            DBFireBase.creatStoreDescription { storeSettings in
                                StoreTableViewController.currentStoreSettings = storeSettings
                            }
                            
                            self.showGlobalMenuVC()
                            
                            // удаление экрана авторизации из стека
                            var navigationControllers = self.navigationController?.viewControllers
                            navigationControllers?.remove(at: 0)
                            self.navigationController?.viewControllers = navigationControllers!
                            
                        }
                    } else {
                        self.customAlert(text: "Неверный пароль")
                        self.clearAllFields()
                    }
                }
            }
            
            
            //MARK: USER signIn
            
        } else if choiceRegistrationRole.selectedSegmentIndex == 1 {
            signOutFireBase()
            
            // закладка юзер, регистрация
            
            if questionEnterButton.titleLabel?.text == "Войти" {
                
                showAlert()
                
                Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!) {  (result, error) in
                    if error == nil {
                        if let result = result {
                            
                            let db = Firestore.firestore()
                            db.collection("users").document(self.emailField.text!).setData([
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
                            
                            // удаление экрана авторизации из стека
                            var navigationControllers = self.navigationController?.viewControllers
                            navigationControllers?.remove(at: 0)
                            self.navigationController?.viewControllers = navigationControllers!
                        }
                    } else { self.customAlert(text: "Неверный пароль")
                    }
                    self.clearAllFields()
                    
                }
                
                
                // закладка юзер, вход
                
            } else if questionEnterButton.titleLabel?.text == "Регистрация" {
                AuthAccaunt.authProfile = .user
                showAlert()
                
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            
                            AuthAccaunt.statusLog = .loged
                            self.statusLabel.text = "Зарегистрирован"
                            
                            self.showTimeLineVC()
                            
                            // удаление экрана авторизации из стека
                            var navigationControllers = self.navigationController?.viewControllers
                            navigationControllers?.remove(at: 0)
                            self.navigationController?.viewControllers = navigationControllers!
                        }
                    } else {
                        self.customAlert(text: "Неверный пароль")
                        self.clearAllFields()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    
    //MARK: custom functions
    
    func showGlobalMenuVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
        
        self.navigationController?.pushViewController(globalMenu, animated: true)
    }
    
    func showTimeLineVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timeLine = storyboard.instantiateViewController(withIdentifier: "TimeLineCollectionViewController") as! TimeLineCollectionViewController
        
        self.navigationController?.pushViewController(timeLine, animated: true)
        self.navigationController?.tabBarItem.isEnabled = true
        
    }
    
    func showSettingsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settings = storyboard.instantiateViewController(withIdentifier: "StoreSettingsTableViewController") as! StoreTableViewController
        
        self.navigationController?.pushViewController(settings, animated: true)
        
    }
    
    
    func customAlert(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Исправить", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // проверка на заполнение полей
    func showAlert() {
        
        let alert = generateAlert()
        if  alert != "Вы не заполнили: \n" {
            let alertControllerAttention = UIAlertController(title: "Внимание!", message: alert, preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "Вернуться и добавить", style: .default, handler: nil)
            alertControllerAttention.addAction(alertAction)
            alerts.removeAll()
            present(alertControllerAttention, animated: true, completion: nil)
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
    
    // создание списка незаполненных полей
    func generateAlert() -> String {
        if questionEnterButton.titleLabel?.text == "Регистрация" {
            alerts.append("Вы не заполнили: \n")
            
            if self.emailField.text == "" {
                alerts.append(alertEnumAuth.noEmail.rawValue + "\n")
            }
            
        } else if questionEnterButton.titleLabel?.text == "Войти" {
            alerts.append("Вы не заполнили: \n")
            
            if self.nameField.text == "" {
                alerts.append(alertEnumAuth .noName.rawValue + "\n")
            }
            
            if self.emailField.text == "" {
                alerts.append(alertEnumAuth.noEmail.rawValue + "\n")
            }
            
            if self.passwordField.text == "" {
                alerts.append(alertEnumAuth.noPassword.rawValue + "\n")
            }
        }
        return self.alerts
    }
    
    
    //MARK: стандартные функции
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    //скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
