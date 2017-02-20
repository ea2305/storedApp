//
//  AddProductController.swift
//  SimpleStoreControl
//
//  Created by Elihu Alejandro Cruz Albores on 2/18/17.
//  Copyright © 2017 ObjectiveCTeam. All rights reserved.
//

import UIKit
import CoreData

class AddProductController: UIViewController {
    
    private var myItems:[Product] = []
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var information: UITextView!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var price: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addDataToDataBase(_ sender: Any) {
        
        print("it's works")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)

        product.name = name.text
        product.infomation = information.text
        product.price = (price.text! as NSString ).doubleValue
        product.quantity = Int16(( quantity.text! as NSString).intValue)

        
        //Save date information
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let alert = UIAlertController(title: "Saved data", message: "The product was writing", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

        alert.addAction(okAction)
        
        // Display information
        self.present(alert, animated: true, completion: nil)
        
        //Clean all scope of inputs
        name.text        = ""
        price.text       = ""
        quantity.text    = ""
        information.text = "Write a great description to share the main idea of the product"
        
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
