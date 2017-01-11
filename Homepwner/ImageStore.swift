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
    }
    
    open func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    open func deleteImageForKey(key: String) -> Void {
        cache.removeObject(forKey: key as NSString)
    }
}
