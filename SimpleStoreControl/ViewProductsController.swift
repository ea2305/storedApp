//
//  ViewProductsController.swift
//  SimpleStoreControl
//
//  Created by Elihu Alejandro Cruz Albores on 2/19/17.
//  Copyright © 2017 ObjectiveCTeam. All rights reserved.
//

import UIKit

class ViewProductsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableProducts: UITableView!
    
    var products : [Product] = []
    var currentRow : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TableProducts.dataSource = self
        TableProducts.delegate = self
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let product = products[indexPath.row]
        
        cell.textLabel?.text = product.name! + "\t Cost: $" + String(product.price)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        currentRow = indexPath.row
        //performSegue(withIdentifier: "DeleteUpdate", sender: nil)
        
        performSegue(withIdentifier: "SelectItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectItem"{
            print("works")
            let controller = segue.destination as! UpdateDeleteViewController
            controller.passValue = currentRow
            navigationItem.title = "Products"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
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

    
}
