//
//  MessageTVC.swift
//  Garment
//
//  Created by Максим Артемов on 21.04.2022.
//

import UIKit

// Таблица входящих Сообщений от Покупателей в Магазин
class MessageTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // регистрируем ячейку
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Message")
        // создаем массивы Текстов, Дат и Авторов
        self.getNumberOfItems()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // устанавливаем количество Ячеек а Таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.texts.count
    }
    
    // формируем Ячейку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Message", for: indexPath)
        // конфигурируем стандартные объекты Ячейки
        var content = cell.defaultContentConfiguration()
        // indexPath для краткости
        let index = indexPath.row
        // заполняем поле Текст - в самом верху Ячейки
        content.text = self.texts[index]
        // заполняем второстепенный текст - внизу Ячейки
        content.secondaryText = """
                                \(self.authors[index]).
                                Дата: \(self.dates[index])
                                """
        // добавляем сконфигурированные объекты к Ячейке
        cell.contentConfiguration = content

        return cell
    }
    
    
    // MARK: - CUSTUM FUNCTIONS
    
    // функция получения количества Сообщений и создания массивов Текстов, Дат и Авторов
    // VARs
    var texts: [String] = []
    var dates: [String] = []
    var authors: [String] = []
    
    func getNumberOfItems() -> Int {
        // получаем Продукты, в которых есть сообщения. Вообще все магазины из БД
        let prdcts = DataBase.allProductsDB.filter { product in
            !product.messages.isEmpty
        }
        // получаем Продукты текущего Магазина, в которых есть Сообщения
        let products = prdcts.filter { prod in
            prod.store == AuthAccaunt.nameStore
        }
        
        // проходимся по всем Товарам, удовлетворяющим вышеописанное требование
        for prod in products {
            // в каждом Товаре берем все сообщения и проходим по каждому из них, создавая массивы Текстов, Дат и Авторов
            for message in prod.messages {
                self.texts.append(message.text)
                self.dates.append(String(describing: message.date))
                self.authors.append(message.author)
            }
        }
        // возвращаем количество полученных Сообщений для присвоения количеству секуций в Таблице TableViewController
        return self.texts.count
    }


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

}
