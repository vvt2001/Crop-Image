//
//  ViewController.swift
//  Crop Image
//
//  Created by Vũ Việt Thắng on 15/06/2022.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet private weak var imageCroppingView: UIImageView!
    @IBOutlet private weak var rotateCounterclockwiseButton: UIButton!
    @IBOutlet private weak var rotateClockwiseButton: UIButton!
    @IBOutlet private weak var flipImageButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private var imageAssets = [PHAsset]()
    private var croppingLayerView = CroppingLayerView.loadView()
    
    private func setupImageView(){
        let randomImageAsset = self.imageAssets.randomElement()
        // get image or video's thumbnail
        let manager = PHImageManager.default()
        manager.requestImage(for: randomImageAsset!, targetSize: CGSize(width: self.imageCroppingView.frame.width, height: self.imageCroppingView.frame.height), contentMode: .aspectFit, options: nil){ image, _ in
            self.imageCroppingView.image = image
        }
    }
    
    private func loadAssetFromLibrary(){
        PHPhotoLibrary.requestAuthorization{ status in
            if status == .authorized {
                let videoAssets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                videoAssets.enumerateObjects{ (object, _, _) in
                    self.imageAssets.append(object)
                }
                DispatchQueue.main.async {
                    self.setupImageView()
                }
            }
        }
    }
    
    @IBAction private func rotateImageViewClockwise(_ sender: UIButton){
        self.imageCroppingView.image = self.imageCroppingView.image?.rotate(radians: .pi/2)
    }

    @IBAction private func rotateImageViewCounterClockwise(_ sender: UIButton){
        self.imageCroppingView.image = self.imageCroppingView.image?.rotate(radians: -(.pi/2))
    }
    
    @IBAction private func flipImageView(_ sender: UIButton){
        self.imageCroppingView.image = self.imageCroppingView.image?.withHorizontallyFlippedOrientation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadAssetFromLibrary()
        croppingLayerView.frame = imageCroppingView.bounds
        imageCroppingView.addSubview(croppingLayerView)
    }

}

