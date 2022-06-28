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
    
    @objc func showAlert(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        var title = String()
        var message = String()
        if error == nil{
            title = "Image saved"
            message = "Image has been saved to Library"
        }
        else {
            title = "Error"
            message = "Image could not be saved. An error has occured!"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction private func saveImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(croppedImage, self, #selector(showAlert), nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        croppedImageView.image = croppedImage
    }
}
