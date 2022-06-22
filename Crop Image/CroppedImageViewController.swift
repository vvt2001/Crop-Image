//
//  CroppedImageViewController.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 17/06/2022.
//

import UIKit

class CroppedImageViewController: UIViewController {

    @IBOutlet private weak var croppedImageView: UIImageView!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    var croppedImage: UIImage!
    
    @IBAction private func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction private func saveImage(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        croppedImageView.image = croppedImage
    }
}
