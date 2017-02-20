//
//  UpdateDeleteViewController.swift
//  SimpleStoreControl
//
//  Created by Elihu Alejandro Cruz Albores on 2/19/17.
//  Copyright © 2017 ObjectiveCTeam. All rights reserved.
//

import UIKit

class UpdateDeleteViewController: UIViewController {
    
    var passValue : Int = 0
    var products : [Product] = []
    
    
    //Components
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var information: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Get all data from DataCore IOS
        getData()
        
        //current product
        let current_product : Product = products[passValue]
        
        navigationItem.title = current_product.name
        
        //Set all information of product
        name.text = current_product.name
        price.text = String( current_product.price )
        quantity.text = String( current_product.quantity )
        information.text = current_product.infomation
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateProduct(_ sender: Any) {
        
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        let alert = UIAlertController(title: "Update Product", message: "The data will be updated", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            
            self.products[self.passValue].name = self.name.text
            self.products[self.passValue].infomation = self.information.text
            self.products[self.passValue].price = ( self.price.text! as NSString ).doubleValue
            self.products[self.passValue].quantity = Int16(( self.quantity.text! as NSString).intValue)
            
            appDelegate.saveContext()
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
        
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        
        // 5
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        
        let alert = UIAlertController(title: "Delete Product", message: "Are You really sure.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            
            context.delete(self.products[self.passValue])
            
            appDelegate.saveContext()
            //self.performSegue(withIdentifier: "viewProducts", sender: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        // display information of alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    /*
     Obtiene toda la informacion de la base de datos
     
     */
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            products = try context.fetch(Product.fetchRequest())
        }catch{
            print("Error in fetching data")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
