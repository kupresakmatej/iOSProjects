//
//  ViewController.swift
//  FlagList
//
//  Created by Matej Kuprešak on 09.09.2023..
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag List"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("2x.png") {
                pictures.append(item)
            }
        }
        
        print(pictures.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        pictures.sort()
        
        let pictureSplit = pictures[indexPath.row].split(separator: "@")
        let pictureToShow = pictureSplit[0]
        
        cell.textLabel?.text = String(pictureToShow).uppercased()
        cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
        
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        cell.imageView?.layer.borderWidth = 1.0
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            let pictureSplit = pictures[indexPath.row].split(separator: "@")
            let pictureToShow = pictureSplit[0]
            
            vc.countryName = String(pictureToShow).uppercased()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

