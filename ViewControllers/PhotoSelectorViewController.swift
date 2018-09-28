//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Xavier on 9/27/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import CloudKit

//You will also define a protocol for the `PhotoSelectorViewController` class to communicate with it's parent view controller.
protocol PhotoSelectorViewControllerDelegate: class{
    func photoSelcted(_ photo: UIImage)
}



class PhotoSelectorViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    weak var delegate: PhotoSelectorViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectPhotoButton.setTitle("Select a Picture", for: .normal)
        imageView.image = nil
    }
    
    @IBAction func selectPhotoButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
    }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
}
}

extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectPhotoButton.setTitle("", for: .normal)
            imageView.image = photo
            delegate?.photoSelcted(photo)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
