//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Xavier on 9/25/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var enterCaptionTextField: UITextField!
    
    var photo: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectVC"{
            guard let destinationVC = segue.destination as? PhotoSelectorViewController else {return}
            destinationVC.delegate = self
        }
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIButton) {
        guard let photo = photo, let caption = enterCaptionTextField.text, !caption.isEmpty else { return}
        
        PostController.shared.createPostWith(photo: photo, captionText: caption) { (post) in
        }
        self.tabBarController?.selectedIndex = 0
    }
}


extension AddPostTableViewController: PhotoSelectorViewControllerDelegate{
    func photoSelcted(_ photo: UIImage) {
        self.photo = photo
    }

}
