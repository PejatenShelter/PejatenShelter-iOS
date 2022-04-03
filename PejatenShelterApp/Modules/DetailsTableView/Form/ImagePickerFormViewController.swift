//
//  ImagePickerFormViewController.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 28/05/22.
//

import UIKit
import Kingfisher

final class ImagePickerFormViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet private weak var modalStackView: UIStackView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    
    var dismissAction: () -> Void = {}
    var saveAction: (UIImage) -> Void = { _ in }
    
    private var formImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        setupModalRoundedCorners()
        setupImageView()
    }
    
    private func setupModalRoundedCorners() {
        modalStackView.clipsToBounds = true
        modalStackView.layer.cornerRadius = 8
        modalStackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupImageView() {
        if let formImage = formImage {
            imageView.image = formImage
            imageView.contentMode = .scaleAspectFill
            changeImageButton.setTitle("Ganti Foto", for: .normal)
        }
        setupRoundImageView()
    }
    
    private func setupRoundImageView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
    }
    
    func setup(image: UIImage?) {
        formImage = image
    }
    
    private func showImagePickerOptions() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertVC.view.tintColor = R.color.accentColor()
        
        let cameraAction = UIAlertAction(title: "Ambil Foto", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            let cameraImagePicker = self.imagePicker(for: .camera)
            self.present(cameraImagePicker, animated: true)
        }
        alertVC.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: "Pilih Foto", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            let libraryImagePicker = self.imagePicker(for: .photoLibrary)
            self.present(libraryImagePicker, animated: true)
        }
        alertVC.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Batal", style: .cancel)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true)
    }
    
    private func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = sourceType
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        return imagePickerVC
    }
    
    @IBAction func didTapChangeImageButton(_ sender: UIButton) {
        showImagePickerOptions()
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        dismissAction()
    }
    
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        guard let value = imageView.image else { return }
        saveAction(value)
        dismissAction()
    }
    
}

extension ImagePickerFormViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        imageView.image = image
        changeImageButton.setTitle("Ganti Foto", for: .normal)
        dismiss(animated: true)
    }
}
