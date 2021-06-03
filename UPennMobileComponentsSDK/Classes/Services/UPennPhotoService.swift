//
//  UPennPhotoService.swift
//  UPennMobileComponentsSDK
//
//  Created by Rashad Abdul-Salam on 6/11/21.
//

import Foundation
import UIKit

public protocol UPennImagePickerDelegate {
    func didSelect(image: UIImage?)
}

open class UPennPhotoService : NSObject {
    
    public var presentationController : UIViewController
    public let pickerController = UIImagePickerController()
    public var imagePickerDelegate: UPennImagePickerDelegate?
    
    public init(_ viewController: UIViewController, delegate: UPennImagePickerDelegate) {
        self.presentationController = viewController
        self.imagePickerDelegate = delegate
        super.init()
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    public func pickPhoto() {
        self.pickerController.sourceType = .photoLibrary
        self.presentationController.present(self.pickerController, animated: true)
    }
    
    public func takePhoto() {
        self.pickerController.sourceType = .camera
        self.presentationController.present(self.pickerController, animated: true)
    }
}

extension UPennPhotoService: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.selectedImage(nil, for: picker)
    }
    
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        guard let image = info[.editedImage] as? UIImage else {
            return self.selectedImage(nil, for: picker)
        }
        self.selectedImage(image, for: picker)
    }
}

private extension UPennPhotoService {
    func selectedImage(_ image: UIImage?, for controller: UIImagePickerController) {
        controller.dismiss(animated: true, completion: nil)
        
        self.imagePickerDelegate?.didSelect(image: image)
    }
}
