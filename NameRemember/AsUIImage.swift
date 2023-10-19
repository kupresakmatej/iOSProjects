//
//  AsUIImage.swift
//  NameRemember
//
//  Created by Matej Kuprešak on 23.08.2023..
//

import Foundation
import SwiftUI

extension View {
    func asUIImage(size: CGSize? = nil) -> UIImage {
           let controller = UIHostingController(rootView: self)
           controller.view.frame = CGRect(origin: .zero, size: size ?? CGSize(width: 200, height: 200))
           let image = controller.view.asImage()
            print("image \(image)")
           return image
       }
}

extension UIView {
    func asImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            if let capturedImage = UIGraphicsGetImageFromCurrentImageContext() {
                return capturedImage
            }
        }
        return UIImage()
    }
}
