//
//  ItemDetailViewController.swift
//  Homepwner
//
//  Created by David on 1/8/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - View Variables
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialNumberTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateCreatedLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Constants
    private let IMAGE_PICKER_ALERT_TITLE: String! = "Input Source"
    private let IMAGE_PICKER_ALERT_MESSAGE: String! = "Choose An Input Source"
    private let CANCEL: String! = "Cancel"
    private let CAMERA: String! = "Camera"
    private let PHOTO_LIBRARY: String! = "Photo Library"
    
    // MARK: - Variables
    var item: Item! {
        didSet {
            navigationItem.title = item.getName()
        }
    }
    
    var imageStore: ImageStore!
    
    // MARK: - Actions
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        let alertController = UIAlertController(title: IMAGE_PICKER_ALERT_TITLE, message: IMAGE_PICKER_ALERT_MESSAGE, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: CANCEL, style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: CAMERA, style: .default, handler: {
            (action) in
            // Check if the device has a camera first - if so, then set the source type to the camera
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        })
        
        let photoLibraryAction = UIAlertAction(title: PHOTO_LIBRARY, style: .default, handler: {
            (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        })
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        // Needed for Ipad Implementation
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = sender as? UIBarButtonItem
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - ImagePickerControllerDelegate Methods
    // Saves the image to the imageView
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Set image in imageStore
        imageStore.setImage(image: image, forKey: item.getItemKey())
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.getName()
        serialNumberTextField.text = item.getSerialNumber()
        valueTextField.text = item.getValue()
        dateCreatedLabel.text = item.getDateCreated()
        imageView.image = imageStore.imageForKey(key: item.getItemKey())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
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
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
