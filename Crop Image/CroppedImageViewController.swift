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
    
    private func showAlert(){
        let title = "Image saved"
        let message = "Image has been saved to Library"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil, nil)
        showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        croppedImageView.image = croppedImage
    }
}
