//
//  ShopViewController.swift
//  SimpleStoreControl
//
//  Created by Elihu Alejandro Cruz Albores on 2/20/17.
//  Copyright © 2017 ObjectiveCTeam. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var TableProducts: UITableView!
    
    var products_to_shop : [ListShop] = []
    var products : [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        TableProducts.dataSource = self
        TableProducts.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let current = products_to_shop[indexPath.row]
        let product = products[Int(current.id)]
        
        cell.textLabel?.text = product.name! + ", quantity: " + String(current.quantity) + ", cost: " + String(product.price * Double( current.quantity ))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            let context = appDelegate.persistentContainer.viewContext

            context.delete(products_to_shop[indexPath.row])
            
            appDelegate.saveContext()
            
            products_to_shop.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products_to_shop.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        print("[ok]")
        //currentRow = indexPath.row
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
        getDataList()
        TableProducts.reloadData()
    }
    
    func getData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            products = try context.fetch(Product.fetchRequest())
        }catch{
            print("Error in fetching data")
        }
    }

    
    func getDataList(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            products_to_shop = try context.fetch(ListShop.fetchRequest())
        }catch{
            print("Error in fetching data")
        }
    }
}
