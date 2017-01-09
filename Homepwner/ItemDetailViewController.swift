//
//  ItemDetailViewController.swift
//  Homepwner
//
//  Created by David on 1/8/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialNumberTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateCreatedLabel: UILabel!
    
    var item: Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.getName()
        serialNumberTextField.text = item.getSerialNumber()
        valueTextField.text = item.getValue()
        dateCreatedLabel.text = item.getDateCreated()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.setName(name: nameTextField.text)
        item.setSerialNumber(serialNumber: serialNumberTextField.text)
        item.setValue(value: valueTextField.text)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
