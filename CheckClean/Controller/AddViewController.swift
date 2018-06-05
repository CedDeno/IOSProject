//
//  AddViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 29/04/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Toast_Swift

protocol AddInfoRapport: NSObjectProtocol {
    func add(local:String, zone:ZoneControl, button:UIButton, progressBar:UIProgressView)
}

class AddViewController: UIViewController {

    var localName: String!
    var delegat: AddInfoRapport!
    var button: UIButton!
    var progressBar: UIProgressView!
    @IBOutlet weak var collectionPictures: UICollectionView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var local: UITextField!
    @IBOutlet weak var raiting: UISlider!
    var pictures = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.5).cgColor
        desc.layer.borderWidth = 0.9
        desc.layer.cornerRadius = 10
        
        
    }

    
    @IBAction func didChangeRaiting(_ sender: UISlider) {
        
        showToast("\(sender.value.rounded(.down))")
    }
    
    @IBAction func tapClose() {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSendRapport(_ sender: Any) {
        if let title = local.text, let des = desc.text, let rate = raiting?.value{
            if pictures.count == 0 {
                let zoneC = ZoneControl(title: title, description: des, rating: rate)
                delegat.add(local: self.localName, zone: zoneC, button: button, progressBar: progressBar )
            }else {
                let zoneC = ZoneControl(title: title, description: des, rating: rate, tabimage: pictures)
                delegat.add(local: self.localName, zone: zoneC, button: button, progressBar: progressBar)
            }
        }
       
    }
    
    func showToast(_ message: String) {
        var img = UIImage(named: "bad")
        var title = ""
        switch Double( message) {
        case 1.0:
            img = UIImage.init(named: "sBad")
            title = "Trés mauvais"
            break
        case 2.0:
            img = UIImage.init(named: "middle")
            title = "Mauvais"
            break
        case 3.0:
            img = UIImage.init(named: "correct")
            title = "Acceptable"
            break
        case 4.0:
            img = UIImage.init(named: "parfait")
            title = "Correct"
            break
        case 5.0:
            img = UIImage.init(named: "star")
            title = "Parfait"
            break
        default:
            break
        }
        
        self.view.makeToast("Note : \(message) / 5.0", duration: 3.0, title: title, image: img, completion: nil)
        
    }
}
extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: "PicturesCollectionViewCell", for: indexPath) as! PicturesCollectionViewCell
        view.image.image = pictures[indexPath.row]
        
        return view
    }
    
}
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func btnTakePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePiker = UIImagePickerController()
            imagePiker.delegate = self
            imagePiker.sourceType = .camera
            imagePiker.allowsEditing = false
            self.present(imagePiker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnLibraryPicture(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePiker = UIImagePickerController()
            imagePiker.delegate = self
            imagePiker.sourceType = .photoLibrary
            imagePiker.allowsEditing = false
            self.present(imagePiker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image =  info[UIImagePickerControllerOriginalImage] as! UIImage
        pictures.append(image)
        collectionPictures.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
