//
//  RemoveBackgroundViewModel.swift
//  Cabide
//
//  Created by Eduardo Brum on 14/04/24.
//

import CoreImage.CIFilterBuiltins
import SwiftUI
import Vision

class RemoveBackgroundViewModel: ObservableObject {
    
    private var processingQueue = DispatchQueue(label: "ProcessingQueue")
    
    @Published var image: UIImage = UIImage()
    @Published var isLoading: Bool = false
    
    func removeBackground(inputClothingImage: UIImage?) {
        self.isLoading = true
        guard let image = inputClothingImage else { return }
        guard let inputCIImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            return
        }

        processingQueue.async {
            guard let maskImage = self.subjectMaskImage(from: inputCIImage) else {
                print("Failed to create mask image")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            let outputImage = self.apply(mask: maskImage, to: inputCIImage)
            let image = self.render(ciImage: outputImage, scale: image.scale, orientation: image.imageOrientation)
            
            DispatchQueue.main.async {
                self.image = image
                self.isLoading = false
            }
        }
    }
    
    private func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
        } catch {
            print(error)
            return nil
        }
        
        guard let result = request.results?.first else {
            print("No observations found")
            return nil
        }
        do {
            let maskPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: maskPixelBuffer)
        } catch {
            print(error)
            return nil
        }
    }
    
    private func apply(mask: CIImage, to image: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }
    
    private func render(ciImage: CIImage, scale: CGFloat, orientation: UIImage.Orientation) -> UIImage {
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        
        return UIImage(cgImage: cgImage, scale: scale, orientation: orientation)
    }
}
