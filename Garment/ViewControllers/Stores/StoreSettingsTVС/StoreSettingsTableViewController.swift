//
//  StoreSettingsTableViewController.swift
//  Garment
//
//  Created by Максим Артемов on 05.10.2021.
//

import UIKit
//import Firebase

class StoreSettingsTableViewController: UITableViewController {
    
    var category: Store.StoreCategory.RawValue = ""
    
    var alerts: String = "" // массив ошибок заполнения полей
    
    static var currentStoreSettings: Store?
    
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
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var vk: UITextField!
    @IBOutlet weak var ok: UITextField!
    @IBOutlet weak var fb: UITextField!
    @IBOutlet weak var telephon: UITextField!
    @IBOutlet weak var waLink: UITextField!
    @IBOutlet weak var numberWA: UITextField!
    @IBOutlet weak var e_mail: UITextField!
    @IBOutlet weak var url: UITextField!
    
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
    @IBOutlet weak var categoryButton: UIButton!
    
    
    
    
    // logo
    @IBOutlet weak var logo: UIImageView!
    
    
    //IBActions
    //    buttons
    @IBAction func nameButtonAction(_ sender: Any) {
        changeButtonImage(button: nameButtonOutlet, field: name)
    }
    @IBAction func descriptionButtonAction(_ sender: Any) {
        changeButtonImage(button: descriptionButtonOutlet, field: descript)
    }
    //    @IBAction func categoryButtonAction(_ sender: Any) {
    //        changeButtonImage(button: categoryButtonOutlet, field: categoryButton)
    //    }
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
    
    @IBAction func toGlobalMenuButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
        self.navigationController?.pushViewController(globalMenu, animated: true)
        self.navigationController?.setViewControllers([globalMenu], animated: true)
    }
    
    
    //MARK: custom functions
    
    func fillingCategoryMenu() {
        
        // пункты всплывающего меню
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Обувь", image: nil, handler: { (_) in
                    self.category = Store.StoreCategory.shoes.rawValue
                }),
                UIAction(title: "Одежда", image: nil, handler: { (_) in
                    self.category = Store.StoreCategory.clothes.rawValue                }),
                UIAction(title: "Спортивная одежда", image: nil, handler: { (_) in
                    self.category = Store.StoreCategory.sportWears.rawValue                }),
                UIAction(title: "Купальники", image: nil, handler: { (_) in
                    self.category = Store.StoreCategory.swimsuits.rawValue                }),
                UIAction(title: "Шубы", image: nil, handler: { (_) in
                    self.category = Store.StoreCategory.furCoats.rawValue                })
            ]
        }
        
        var categoruButtonMenu: UIMenu {
            return UIMenu(title: "Категория магазина", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        categoryButton.menu = categoruButtonMenu
        
    }
    
    //        loadig settings
    func loadingSettingsStore() {
//        uploadToAccaunt()
        let store = AuthAccaunt.nameStore
        //                self.logo.image = currentStoreSettings?.logo
        self.name.text = DataBase.allStoresDB[store]?.name
        self.descript.text = DataBase.allStoresDB[store]?.description
        //            self.category.text = StoreSettingsTableViewController.currentStoreSettings?.category
        self.url.text = DataBase.allStoresDB[name.text!]?.url
        self.instagram.text = DataBase.allStoresDB[store]?.instagram
        self.vk.text = DataBase.allStoresDB[store]?.vKontakte
        self.ok.text = DataBase.allStoresDB[store]?.odniklassniki
        self.fb.text = DataBase.allStoresDB[store]?.facebook
        self.telephon.text = DataBase.allStoresDB[store]?.telephonNumber
        self.waLink.text = DataBase.allStoresDB[store]?.whatsAppLink
        self.numberWA.text = DataBase.allStoresDB[store]?.whatsAppNumber
        self.e_mail.text = DataBase.allStoresDB[store]?.email
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
    
    //        заполняем данные магазина
    
//    func uploadToAccaunt() {
//
//        self.name.isHidden = false
//        self.name.text = DataBase.stores[name.text!]?.name
//
//        self.descript.isHidden = false
//        self.descript.text = DataBase.stores[name.text!]?.description
//
//        //                    self.category.isHidden = false
//        //                    self.category.text = DataBase.stores[name.text!]?.category
//
//        self.instagram.isHidden = false
//        self.instagram.text = DataBase.stores[name.text!]?.instagram
//
//        self.vk.isHidden = false
//        self.vk.text = DataBase.stores[name.text!]?.vKontakte
//
//        self.ok.isHidden = false
//        self.ok.text = DataBase.stores[name.text!]?.odniklassniki
//
//        self.fb.isHidden = false
//        self.fb.text = DataBase.stores[name.text!]?.facebook
//
//        self.telephon.isHidden = false
//        self.telephon.text = DataBase.stores[name.text!]?.telephonNumber
//
//        self.waLink.isHidden = false
//        self.waLink.text = DataBase.stores[name.text!]?.whatsAppLink
//
//        self.numberWA.isHidden = false
//        self.numberWA.text = DataBase.stores[name.text!]?.whatsAppNumber
//
//        self.e_mail.isHidden = false
//        self.e_mail.text = DataBase.stores[name.text!]?.email
//
//    }
    
    
    
    
    //    деактивируем поля при загрузке view
    func disableAccauntFields () {
        name.isEnabled = false
        descript.isEnabled = false
        categoryButton.isEnabled = false
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
    
//    func codingURL(stringUrl: String) -> URL {
//        let urlString = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
//        let url = URL(string: urlString!)!
//        return url
//    }
    
    //        добавление в магазина в локальную базу данных
    func addStoreToDB() {
        
        
        DataBase.allStoresDB = [AuthAccaunt.nameStore: Store(/*logo: UIImage(systemName: "pencil"),*/
                                 name: name.text!,
                                 description: descript.text!,
                                 category: nil,
                                 url: "",
                                 instagram: instagram.text!,
                                 vKontakte: vk.text!,
                                 odniklassniki: ok.text!,
                                 facebook: fb.text!,
                                 telephonNumber: telephon.text!,
                                 whatsAppLink: waLink.text!,
                                 whatsAppNumber: numberWA.text!,
                                 email: e_mail.text!,
                                 /*followers: 0,*/
                                 products: nil)
                        ]
//        uploadToAccaunt()
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
            
            //            let alertControllerCongrutalation = UIAlertController(title: "Отлично!", message: "Поздравляем с регистрацией магазина", preferredStyle: .actionSheet)
            //            let alertAction = UIAlertAction(title: "Приступить к работе", style: .default, handler: nil)
            //            alertControllerCongrutalation.addAction(alertAction)
            //            alerts.removeAll()
            //            present(alertControllerCongrutalation, animated: true, completion: nil)
            //
            // переход в глобальное меню после заполнения всех полей описания магазина
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let globalMenu = storyboard.instantiateViewController(withIdentifier: "GlobalMenuStoreViewController") as! GlobalMenuStoreViewController
            
            self.navigationController?.pushViewController(globalMenu, animated: true)
            
            self.navigationController?.setViewControllers([globalMenu], animated: true)
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
        
        self.loadingSettingsStore()
        
        disableButtons()
        name.becomeFirstResponder()
        fillingCategoryMenu()
    }
}
