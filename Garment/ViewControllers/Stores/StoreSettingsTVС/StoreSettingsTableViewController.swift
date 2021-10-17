//
//  StoreSettingsTableViewController.swift
//  Garment
//
//  Created by Максим Артемов on 05.10.2021.
//

import UIKit
import Firebase
import AudioToolbox

class StoreSettingsTableViewController: UITableViewController {
    
    var alerts: String = "" // массив ошибок заполнения полей
    
    enum alertEnum: String {
        
        case noName = " название магазина"
        case noDescription = " описание магазина "
        case noInstagram = " ссылку на Instagram-аккаунт"
        case noVK = " ссылку на ВКонтакте-аккаунт"
        case noOK = " ссылку на Одноклассники-аккаунт"
        case noFB = " ссылку на Facebook-аккаунт"
        case noPhoneNumber = " номер телефона магазина"
        case noWANumber = " номер телефона WhatsApp"
        case noWAURL = " ссылку на WhatsApp"
        case noEmail = " e-mail"
        case noLogo = " логотип магазина"
        case noCategory = " категории магазина"
    }
    
    //IBOutlets
    
    //accaunt
    //    TextFields
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var descript: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var vk: UITextField!
    @IBOutlet weak var ok: UITextField!
    @IBOutlet weak var fb: UITextField!
    @IBOutlet weak var telephon: UITextField!
    @IBOutlet weak var waLink: UITextField!
    @IBOutlet weak var numberWA: UITextField!
    @IBOutlet weak var e_mail: UITextField!
    
    //    Buttons Outlets
    @IBOutlet weak var nameButtonOutlet: UIButton!
    @IBOutlet weak var descriptionButtonOutlet: UIButton!
    @IBOutlet weak var categoryButtonOutlet: UIButton!
    @IBOutlet weak var instagramButtonOutlet: UIButton!
    @IBOutlet weak var vkButtonOutlet: UIButton!
    @IBOutlet weak var okButtonOutlet: UIButton!
    @IBOutlet weak var fbButtonOutlet: UIButton!
    @IBOutlet weak var telephonButtonOutlet: UIButton!
    @IBOutlet weak var waLinkButtonOutlet: UIButton!
    @IBOutlet weak var numberWAButtonOutlet: UIButton!
    @IBOutlet weak var e_mailButtonOutlet: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    
    //IBActions
    //    buttond
    @IBAction func nameButtonAction(_ sender: Any) {
        changeButtonImage(button: nameButtonOutlet, field: name)
    }
    @IBAction func descriptionButtonAction(_ sender: Any) {
        changeButtonImage(button: descriptionButtonOutlet, field: descript)
    }
    @IBAction func categoryButtonAction(_ sender: Any) {
        changeButtonImage(button: categoryButtonOutlet, field: category)
    }
    @IBAction func instagramButtonAction(_ sender: Any) {
        changeButtonImage(button: instagramButtonOutlet, field: instagram)
    }
    @IBAction func vkButtonAction(_ sender: Any) {
        changeButtonImage(button: vkButtonOutlet, field: vk)
    }
    @IBAction func okButtonAction(_ sender: Any) {
        changeButtonImage(button: okButtonOutlet, field: ok)
    }
    @IBAction func fbButtonAction(_ sender: Any) {
        changeButtonImage(button: fbButtonOutlet, field: fb)
    }
    @IBAction func telephonButtonAction(_ sender: Any) {
        changeButtonImage(button: telephonButtonOutlet, field: telephon)
    }
    @IBAction func waLinkButtonAction(_ sender: Any) {
        changeButtonImage(button: waLinkButtonOutlet, field: waLink)
    }
    @IBAction func numberWAButtonAction(_ sender: Any) {
        changeButtonImage(button: numberWAButtonOutlet, field: numberWA)
    }
    @IBAction func e_mailButtonAction(_ sender: Any) {
        changeButtonImage(button: e_mailButtonOutlet, field: e_mail)
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        showAlert()
        addStoreToDB()
        activateButtons()
        saveButtonOutlet.isHidden = true
        
        nameButtonOutlet.backgroundColor = .systemBlue
        descriptionButtonOutlet.backgroundColor = .systemBlue
        categoryButtonOutlet.backgroundColor = .systemBlue
        instagramButtonOutlet.backgroundColor = .systemBlue
        vkButtonOutlet.backgroundColor = .systemBlue
        okButtonOutlet.backgroundColor = .systemBlue
        fbButtonOutlet.backgroundColor = .systemBlue
        telephonButtonOutlet.backgroundColor = .systemBlue
        waLinkButtonOutlet.backgroundColor = .systemBlue
        numberWAButtonOutlet.backgroundColor = .systemBlue
        e_mailButtonOutlet.backgroundColor = .systemBlue
        
    }
    
    //MARK: custom functions
    
    //    update Store
    func updateStore() {
        DataBase.stores[name.text!] =
        
        Store(
            logo: UIImage(systemName: "pencil"),
            name: name.text!,
            description: descript.text!,
            category: nil,
            url: nil,
            instagram: instagram.text!,
            vKontakte: vk.text!,
            odniklassniki: ok.text!,
            facebook: fb.text!,
            telephonNumber: telephon.text!,
            whatsAppLink: waLink.text!,
            whatsAppNumber: numberWA.text!,
            email: e_mail.text!,
            workTime: nil,
            followers: 0,
            product: nil)
    }
    
    //    скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //    меняем название кнопок
    func changeButtonImage(button: UIButton, field: UITextField) {
        if button.tag == 0 {
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            button.backgroundColor = .green
            field.isEnabled = true
            button.tag = 1
            field.becomeFirstResponder()
        } else if button.tag == 1 {
            button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            button.backgroundColor = .systemBlue
            field.isEnabled = false
            button.tag = 0
            updateStore()
        }
    }
    
    //    активируем кнопки
    func activateButtons() {
        nameButtonOutlet.isEnabled = true
        descriptionButtonOutlet.isEnabled = true
        categoryButtonOutlet.isEnabled = true
        instagramButtonOutlet.isEnabled = true
        vkButtonOutlet.isEnabled = true
        okButtonOutlet.isEnabled = true
        fbButtonOutlet.isEnabled = true
        telephonButtonOutlet.isEnabled = true
        waLinkButtonOutlet.isEnabled = true
        numberWAButtonOutlet.isEnabled = true
        e_mailButtonOutlet.isEnabled = true
    }
    
    //    деактивируем кнопки
    func disableButtons() {
        nameButtonOutlet.isEnabled = false
        nameButtonOutlet.backgroundColor = .systemGray
        
        descriptionButtonOutlet.isEnabled = false
        descriptionButtonOutlet.backgroundColor = .systemGray
        
        categoryButtonOutlet.isEnabled = false
        categoryButtonOutlet.backgroundColor = .systemGray
        
        instagramButtonOutlet.isEnabled = false
        instagramButtonOutlet.backgroundColor = .systemGray
        
        vkButtonOutlet.isEnabled = false
        vkButtonOutlet.backgroundColor = .systemGray
        
        okButtonOutlet.isEnabled = false
        okButtonOutlet.backgroundColor = .systemGray
        
        fbButtonOutlet.isEnabled = false
        fbButtonOutlet.backgroundColor = .systemGray
        
        telephonButtonOutlet.isEnabled = false
        telephonButtonOutlet.backgroundColor = .systemGray
        
        waLinkButtonOutlet.isEnabled = false
        waLinkButtonOutlet.backgroundColor = .systemGray
        
        numberWAButtonOutlet.isEnabled = false
        numberWAButtonOutlet.backgroundColor = .systemGray
        
        e_mailButtonOutlet.isEnabled = false
        e_mailButtonOutlet.backgroundColor = .systemGray
        
    }
    
    //    заполняем данные магазина
    func uploadToAccaunt() {
        name.isHidden = false
        name.text = name.text
        
        descript.isHidden = false
        descript.text = DataBase.stores[name.text!]?.description
        
        //        category.isHidden = false
        //        category.text = DataBase.stores[name.text!]?.category
        
        instagram.isHidden = false
        instagram.text = DataBase.stores[name.text!]?.instagram
        
        vk.isHidden = false
        vk.text = DataBase.stores[name.text!]?.vKontakte
        
        ok.isHidden = false
        ok.text = DataBase.stores[name.text!]?.odniklassniki
        
        fb.isHidden = false
        fb.text = DataBase.stores[name.text!]?.facebook
        
        telephon.isHidden = false
        telephon.text = DataBase.stores[name.text!]?.telephonNumber
        
        waLink.isHidden = false
        waLink.text = DataBase.stores[name.text!]?.whatsAppLink
        
        numberWA.isHidden = false
        numberWA.text = DataBase.stores[name.text!]?.whatsAppNumber
        
        e_mail.isHidden = false
        e_mail.text = DataBase.stores[name.text!]?.email
        
    }
    
    
    
    
    //    деактивируем поля при загрузке view
    func disableAccauntFields () {
        name.isEnabled = false
        descript.isEnabled = false
        category.isEnabled = false
        instagram.isEnabled = false
        vk.isEnabled = false
        ok.isEnabled = false
        fb.isEnabled = false
        telephon.isEnabled = false
        waLink.isEnabled = false
        numberWA.isEnabled = false
        e_mail.isEnabled = false
    }
    
    
    //    кодирование url
    
    func codingURL(stringUrl: String) -> URL {
        let urlString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let url = URL(string: urlString!)!
        return url
    }
    
    //        добавление в магазина в базу данных
    func addStoreToDB() {
        
        FSStoreSettings().addSettingsStoreToFireStore(name: name.text!, description: descript.text!, category: "", url: "", instagram: instagram.text!, vk: vk.text!, ok: ok.text!, fb: fb.text!, telephon: telephon.text!, waLink: waLink.text!, numberWA: numberWA.text!, e_mail: e_mail.text!, workTime: "", followers: "", products: "")
        
        DataBase.stores = [self.name.text! : Store(logo: UIImage(systemName: "pencil"),
                                                   name: name.text!,
                                                   description: descript.text!,
                                                   category: nil,
                                                   url: nil,
                                                   instagram: instagram.text!,
                                                   vKontakte: vk.text!,
                                                   odniklassniki: ok.text!,
                                                   facebook: fb.text!,
                                                   telephonNumber: telephon.text!,
                                                   whatsAppLink: waLink.text!,
                                                   whatsAppNumber: numberWA.text!,
                                                   email: e_mail.text!,
                                                   workTime: nil,
                                                   followers: 0,
                                                   product: nil)
        ]
        uploadToAccaunt()
        disableAccauntFields()
    }
    
    //создание алерта
    func showAlert() {
        
        let alert = generateAlert()
        if  alert != "Вы не заполнили: \n" {
            let alertControllerAttention = UIAlertController(title: "Внимание!", message: alert, preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "Вернуться и добавить", style: .default, handler: nil)
            alertControllerAttention.addAction(alertAction)
            alerts.removeAll()
            present(alertControllerAttention, animated: true, completion: nil)
        } else  {
            
            let alertControllerCongrutalation = UIAlertController(title: "Отлично!", message: "Поздравляем с регистрацией магазина", preferredStyle: .actionSheet)
            let alertAction = UIAlertAction(title: "Приступить к работе", style: .default, handler: nil)
            alertControllerCongrutalation.addAction(alertAction)
            alerts.removeAll()
            present(alertControllerCongrutalation, animated: true, completion: nil)
        }
    }
    
    // создание списка незаполненных полей
    func generateAlert() -> String {
        alerts.append("Вы не заполнили: \n")
        
        if self.name.text == "" {
            alerts.append(alertEnum.noName.rawValue + "\n")
        }
        
        if self.descript.text == "" {
            alerts.append(alertEnum.noDescription.rawValue + "\n")
        }
        
        if self.instagram.text == "" {
            alerts.append(alertEnum.noInstagram.rawValue + "\n")
        }
        
        if self.vk.text == "" {
            alerts.append(alertEnum.noVK.rawValue + "\n")
        }
        
        if self.ok.text == "" {
            alerts.append(alertEnum.noOK.rawValue + "\n")
        }
        
        if self.fb.text == "" {
            alerts.append(alertEnum.noFB.rawValue + "\n")
        }
        
        if self.telephon.text == "" {
            alerts.append(alertEnum.noPhoneNumber.rawValue + "\n")
        }
        
        if self.waLink.text == "" {
            alerts.append(alertEnum.noWAURL.rawValue + "\n")
        }
        
        if self.numberWA.text == "" {
            alerts.append(alertEnum.noWANumber.rawValue + "\n")
        }
        
        if self.e_mail.text == "" {
            alerts.append(alertEnum.noEmail.rawValue + "\n")
        }
        return alerts
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButtons()
        name.becomeFirstResponder()
    }
}



//        hideAccauntFields()

// Uncomment the following line to preserve selection between presentations
// self.clearsSelectionOnViewWillAppear = false

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem

// MARK: - Table view data source

//        override func numberOfSections(in tableView: UITableView) -> Int {
//            // #warning Incomplete implementation, return the number of sections
//            return 2
//        }
//
//        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            // #warning Incomplete implementation, return the number of rows
//            return 15
//        }

/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 */

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
