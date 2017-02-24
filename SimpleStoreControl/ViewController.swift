//
//  ViewController.swift
//  SimpleStoreControl
//
//  Created by Elihu Alejandro Cruz Albores on 2/18/17.
//  Copyright © 2017 ObjectiveCTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var products : [Product] = []
    
    @IBOutlet weak var number_elements: UITextField!
    @IBOutlet weak var last_element: UITextField!
    @IBOutlet weak var info_last_element: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            products = try context.fetch(Product.fetchRequest())
            //Agregamos el numero de elementos
            number_elements.text = "Current products: " + String( products.count )
            
            
            if( products == [] ){
                info_last_element.text = "Empty"
            }else{
                last_element.text = products.last!.name
                info_last_element.text = products.last!.infomation
            }
        }catch{
            print("Error to fetch")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

