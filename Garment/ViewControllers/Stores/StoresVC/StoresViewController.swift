//
//  StoresViewController.swift
//  Garment
//
//  Created by Максим Артемов on 19.09.2021.
//

import UIKit

class StoresViewController: UIViewController, UIImagePickerControllerDelegate ,  UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! StorePhotoAlbumCollectionViewCell
        
        
        //       cell.StoresVCCollectionVCPhotoAlbumImage.image = UIImage(systemName: "pencil")
        cell.StoresVCCollectionVCPhotoAlbumImage.image = photos[indexPath.item]
        return cell
    }
    
    
    
    
    //var
    var newProduct = Product(productPostArticle: "", productPostArrayPhotos: [], productPostFirstImage: UIImage(systemName: "pencil")!, productPostTitle: "", productPostDescription: "", productPostPrice: 0, productPostDiscont: 0, productPostFinalPrice: "", productPostSex: Product.Sex.man, productPostSeason: Product.Season.autumn, productPostPublicationDate: "", productPostLikesCount: 0, productPostIsLiked: false, productPostViewsCount: 0, productPostComments: nil, productPostCommentsCount: 0, productPostIsNew: Product.New.isNew, productPostImageCount: 0, store: "")
    
    
    var photos: [UIImage] = []
    
    
    
    //IBOutlets
    //labels
    @IBOutlet weak var StoresVCArticleLabel: UILabel!
    @IBOutlet weak var StoresVCDiscriptionLabel: UILabel!
    @IBOutlet weak var StoresVCSexLabel: UILabel!
    @IBOutlet weak var StoresVCSeasonLabel: UILabel!
    @IBOutlet weak var StoresVCPriceLabel: UILabel!
    @IBOutlet weak var StoresVCDiscountLabel: UILabel!
    @IBOutlet weak var StoresVCFinalPriceLabel: UILabel!
    @IBOutlet weak var StoresVCDatePostingLabel: UILabel!
    @IBOutlet weak var StoreVcProductTitleLabel: UILabel!
    @IBOutlet weak var StoreVCisNewLabel: UILabel!
    
    
    //feilds
    @IBOutlet weak var StoresVCArticleField: UITextField!
    @IBOutlet weak var StoresVCDiscriptionField: UITextView!
    @IBOutlet weak var StoresVCPriceField: UITextField!
    @IBOutlet weak var StoresVCDiscountField: UITextField!
    @IBOutlet weak var StoresVCFinalPriceField: UITextField!
    @IBOutlet weak var StoresVCProductTitleField: UITextField!
    
    
    //SegmentedControllers
    @IBOutlet weak var StoresVCSexSC: UISegmentedControl!
    @IBOutlet weak var StoresVCSeasonSC: UISegmentedControl!
    @IBOutlet weak var StoresVCisNewSC: UISegmentedControl!
    
    
    //Stepper
    @IBOutlet weak var StoresVCDiscountStepper: UIStepper!
    
    //posting date
    @IBOutlet weak var StoresVCPostingDatePicker: UIDatePicker!
    
    //image
    @IBOutlet weak var StoreVСProductImage: UIImageView!
    
    //buttons
    @IBOutlet weak var StoreVCPostingButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCCustomArticleButtonOutlet: UIButton!
    @IBOutlet var StoresVCUploadPhotoButtonOutlet: UIButton!
    @IBOutlet weak var StoresVCUploadFirstPhotoOutlet: UIButton!
    
    //DataPicker
    @IBOutlet weak var StoreVCDataPickerOutlet: UIDatePicker!
    
    //CollectionView
    @IBOutlet weak var StoresVCPhotosCollectionViewOutlet: UICollectionView!
    
    
    
    //IBActions
    //buttons
    //upload first photo
    @IBAction func StoresVCUploadFirstPhotoAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        StoresVCUploadFirstPhotoOutlet.tag = 1
    }
    
    //upload seconds photo
    @IBAction func StoresVCUploadPhotoButtonAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        StoresVCUploadPhotoButtonOutlet.tag = 1
    }
    
    //custom article
    @IBAction func StoresVCCustomArticleButtonAction(_ sender: Any) {
        if StoresVCArticleField.tag == 0 {
            StoresVCArticleField.isEnabled = true
            StoresVCArticleField.backgroundColor = .white
            StoresVCArticleField.becomeFirstResponder()
            StoresVCArticleField.tag = 1
            StoresVCCustomArticleButtonOutlet.setTitle("Сохранить", for: .normal)
        } else if StoresVCArticleField.tag == 1 {
            StoresVCArticleField.isEnabled = false
            StoresVCArticleField.backgroundColor = .opaqueSeparator
            StoresVCProductTitleField.becomeFirstResponder()
            StoresVCArticleField.tag = 0
            StoresVCCustomArticleButtonOutlet.setTitle("Изменить", for: .normal)
        }
    }
    
    
    @IBAction func StoreVCPostingButtonAction(_ sender: Any) {
        self.newProduct = uplodPostToTimeLine()
        controlFillingField()
        generatePhotosAlbumArray()
        
    }
    
    //stepper
    @IBAction func StoreVCDiscountStepperAction(_ sender: Any) {
        StoresVCDiscountField.text = String(Int(StoresVCDiscountStepper.value)) + " %"
        StoresVCFinalPriceField.text = generateFinalPrice()
    }
    
    //datePicker
    @IBAction func StoresVCDataPickerAction(_ sender: Any) {
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //создание артикула
        StoresVCArticleField.text = Product.generateNewArticle()
        
        //установка текущей даты в DataPicker
        StoreVCPostingButtonOutlet.setTitle(generateDatePosting(), for: .normal)
        
        //установка фокуса на поле названия продукта
        StoresVCProductTitleField.becomeFirstResponder()
        
        self.StoresVCPhotosCollectionViewOutlet.dataSource = self
        self.StoresVCPhotosCollectionViewOutlet.delegate = self
        
        //таги для определения нажатой кнопки для уплоада фото
        StoresVCUploadPhotoButtonOutlet.tag = 0
        StoresVCUploadFirstPhotoOutlet.tag = 0
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DataBase.productsDb.append(newProduct)
    }
    
    //скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //custom functions
    
    //save photo in project
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //коллеция фото
        if StoresVCUploadPhotoButtonOutlet.tag == 0 && StoresVCUploadFirstPhotoOutlet.tag == 0 {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            //добавление в массив
            //            newProduct.productPostArrayPhotos?.append(image!)
            photos.append(image!)
            
            //вставка в collection view
            StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
            
            
            StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
            
            picker.dismiss(animated: true, completion: nil)
            
            StoresVCPhotosCollectionViewOutlet.reloadData()
            
            StoresVCUploadPhotoButtonOutlet.tag = 1
            
            
            //главное фото
        }
        
        if StoresVCUploadFirstPhotoOutlet.tag == 1 {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            //добавление в image view
            StoreVСProductImage.image = image
            
            StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
            StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
            //добавление в базу данных
            photos.append(image!)
            
            picker.dismiss(animated: true, completion: nil)
            StoresVCPhotosCollectionViewOutlet.reloadData()
            StoresVCUploadFirstPhotoOutlet.tag = 0
            
        }
        
        if StoresVCUploadPhotoButtonOutlet.tag == 1 {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            //добавление в массив
            //            newProduct.productPostArrayPhotos?.append(image!)
            photos.append(image!)
            
            //вставка в collection view
            StoresVCPhotosCollectionViewOutlet.insertItems(at: StoresVCPhotosCollectionViewOutlet.indexPathsForVisibleItems)
            
            
            StoresVCPhotosCollectionViewOutlet.clipsToBounds = true
            
            picker.dismiss(animated: true, completion: nil)
            
            StoresVCPhotosCollectionViewOutlet.reloadData()
            
            StoresVCUploadPhotoButtonOutlet.tag = 1
        
        
        }
    }
    
    //выбор пола товара
    func choiceSex(sex: Int) -> Product.Sex {
        switch sex {
        case 0: return Product.Sex.man
        case 1: return Product.Sex.woman
        case 2: return Product.Sex.unisex
            
        default:
            return Product.Sex.unisex
        }
    }
    
    //выбор сезено товара
    func choiceSeason(season: Int) -> Product.Season {
        switch season {
        case 0: return Product.Season.winter
        case 1: return Product.Season.spring
        case 2: return Product.Season.summer
        case 3: return Product.Season.autumn
            
        default:
            return Product.Season.winter
        }
    }
    
    //опрделение новизны товара
    func choiceIsNew(isNew: Int) -> Product.New {
        switch isNew {
        case 0: return Product.New.isNew
        case 1: return Product.New.normal
        case 2: return Product.New.sale
            
        default:
            return Product.New.normal
        }
    }
    
    //формирование финальной цены со скидкой
    func generateFinalPrice() -> String {
        let priceFirst = (StoresVCPriceField.text! as NSString).floatValue
        let discountPercent = (StoresVCDiscountField.text! as NSString).floatValue
        let onePercent = priceFirst / 100
        let final = priceFirst - onePercent * discountPercent
        
        return String(final) + " руб."
    }
    
    
    //формирование даты
    func generateDatePosting() -> String {
        let currentDate = StoresVCPostingDatePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        let dateToField = dateFormater.string(for: currentDate)
        return " Опубликовать товар " + dateToField! + " "
    }
    
    //контроль заполнения обязательных полей
    func controlFillingField() {
        
        switch StoresVCProductTitleField.text {
        case "":
            let alert = UIAlertController(title: "Не введено название товара", message: "Укажите название товара", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.StoresVCProductTitleField.becomeFirstResponder()})
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        default:
            self.StoresVCDiscriptionField.becomeFirstResponder()
        }
        
        
        switch StoresVCDiscriptionField.text {
        case "":
            let alert = UIAlertController(title: "Не введено описание товара", message: "Укажите описание товара", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.StoresVCDiscriptionField.becomeFirstResponder()})
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        default:
            self.StoresVCPriceField.becomeFirstResponder()
        }
        
        
        switch StoresVCPriceField.text {
        case "":
            let alert = UIAlertController(title: "Не введена цена товара", message: "Укажите цену товара", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {_ in self.StoresVCPriceField.becomeFirstResponder()})
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        default:
            return
        }
        
    }
    
    //выгрузка поста в ленту
    func uplodPostToTimeLine() -> Product {
        
        FSStores().uplodPostToTimeLineFireStore(
            StoresVCArticleField: self.StoresVCArticleField.text!,
            StoresVCProductTitleField: self.StoresVCProductTitleField.text!,
            StoresVCDiscriptionField: self.StoresVCDiscriptionField.text,
            StoresVCPriceField: self.StoresVCPriceField.text!,
            StoresVCDiscountField: self.StoresVCDiscountField.text!,
            StoresVCFinalPriceField: self.StoresVCFinalPriceField.text!,
//            choiceSex: <#T##String#>,
//            choiceSeason: <#T##String#>,
//            generateDatePosting: <#T##String#>,
            productPostLikesCount: 0,
            productPostIsLiked: false,
            productPostViewsCount: 0,
            productPostCommentsCount: 0
        )
        
        newProduct.productPostArticle = self.StoresVCArticleField.text!
        newProduct.productPostArrayPhotos = []
        
        newProduct.productPostFirstImage = self.StoreVСProductImage.image!
        newProduct.productPostTitle = self.StoresVCProductTitleField.text!
        newProduct.productPostDescription = self.StoresVCDiscriptionField.text
        newProduct.productPostPrice = (self.StoresVCPriceField.text! as NSString).integerValue
        newProduct.productPostDiscont = (self.StoresVCDiscountField.text! as NSString).doubleValue
        newProduct.productPostFinalPrice = self.StoresVCFinalPriceField.text!
        newProduct.productPostSex = choiceSex(sex: self.StoresVCSexSC.selectedSegmentIndex)
        newProduct.productPostSeason = choiceSeason(season: self.StoresVCSeasonSC.selectedSegmentIndex)
        newProduct.productPostPublicationDate = generateDatePosting()
        newProduct.productPostLikesCount = 0
        newProduct.productPostIsLiked = false
        newProduct.productPostViewsCount = 0
        newProduct.productPostComments = []
        newProduct.productPostCommentsCount = 0
        newProduct.productPostIsNew = choiceIsNew(isNew: self.StoresVCisNewSC.selectedSegmentIndex)
        newProduct.productPostImageCount = photos.count
        newProduct.store = AuthAccaunt.nameStore
        
        return newProduct
    }
    
    
    //insert photos in array
    func generatePhotosAlbumArray() {
        //        var i = 0
        let count = photos.count
        for i in 0..<count {
            newProduct.productPostArrayPhotos?.append(photos[i])
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    }

