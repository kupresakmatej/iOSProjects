//
//  DetailViewController.swift
//  FlagList
//
//  Created by Matej Kuprešak on 09.09.2023..
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var countryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countryName
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
                print("No image found")
                return
            }

            let vc = UIActivityViewController(activityItems: [image, "Share the flag"], applicationActivities: [])
        
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
            present(vc, animated: true)
    }
}
