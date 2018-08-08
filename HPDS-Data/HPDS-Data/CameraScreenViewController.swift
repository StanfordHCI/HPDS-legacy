//
//  CameraScreenViewController.swift
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-08-08.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

import UIKit

class CameraScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var CameraButton: UIButton!
    @IBOutlet weak var Cameraview: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        
        present(picker, animated: true, completion: nil)
        
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //TODO: change the below command so it does something other than just display the image on the screen.
        Cameraview.image = info [UIImagePickerControllerOriginalImage] as? UIImage; dismiss(animated: true, completion:nil)
    }

}

