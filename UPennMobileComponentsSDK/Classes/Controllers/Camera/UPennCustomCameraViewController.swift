//
//  UPennCustomCameraViewController.swift
//  Unable To Scan
//
//  Created by Rashad Abdul-Salam on 7/1/19.
//  Copyright © 2019 University of Pennsylvania Health System. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public protocol UPennPhotoCaptureDelegate {
    func didTakePhoto(_ image: UIImage)
    func didCancelPhotoCapture()
}

open class UPennCustomCameraViewController: UPennStoryboardViewController {
    
    @IBOutlet public weak var cameraViewport: UIView!
    
    public var session = AVCaptureSession()
    public var backCamera: AVCaptureDevice?
    public var frontCamera: AVCaptureDevice?
    public var currentCamera: AVCaptureDevice?
    public var photoOutput: AVCapturePhotoOutput?
    public var image: UIImage?
    public var stillImageOutput: AVCaptureOutput?
    public var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    public var photoCaptureDelegate: UPennPhotoCaptureDelegate?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction open func didTapOnTakePhotoButton(_ sender: UIButton) {
        photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @IBAction open func didPressCloseAppButton(_ sender: UIButton) {
        self.dismissModal()
        self.photoCaptureDelegate?.didCancelPhotoCapture()
    }
    
}

extension UPennCustomCameraViewController : AVCapturePhotoCaptureDelegate {
    open func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if
            let imageData = photo.fileDataRepresentation(),
            let image = UIImage(data: imageData)
        {
            self.photoCaptureDelegate?.didTakePhoto(image)
            self.dismissModal()
        }
    }
    
    open func setup() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    open func setupCaptureSession() {
        session.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    open func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    open func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            session.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            session.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    open func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = cameraViewport.bounds
        cameraViewport.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    open func startRunningCaptureSession() {
        session.startRunning()
    }
}
