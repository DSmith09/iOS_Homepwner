//
//  ImageStore.swift
//  Homepwner
//
//  Created by David on 1/10/17.
//  Copyright © 2017 DSmith. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    open func setImage(image: UIImage, forKey key: String) -> Void {
        cache.setObject(image, forKey: key as NSString)
        if saveChanges(image: image, key: key) {
            print("Archived Image Data successfully")
        } else {
            print("Failed to archive image data")
        }
    }
    
    open func imageForKey(key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        return loadDefaultImage(key: <#T##String#>)
    }
    
    open func deleteImageForKey(key: String) -> Void {
        cache.removeObject(forKey: key as NSString)
        do {
            try FileManager.default.removeItem(at: imageURLForKey(key: key) as URL)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    open func saveChanges(image: UIImage, key: String) -> Bool {
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            // TODO: Try Catch in Swift
            do {
                try data.write(to: imageURLForKey(key: key) as URL, options: .atomic)
            } catch let saveError {
                print("Could not write image to File System: \(saveError)")
            }
            return true
        }
        return false
    }
    
    open func loadDefaultImage(key: String) -> UIImage? {
        guard let imageFromDisk = UIImage(contentsOfFile: imageURLForKey(key: key).path!) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    open func imageURLForKey(key: String) -> NSURL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent(key) as NSURL
    }
    
}
