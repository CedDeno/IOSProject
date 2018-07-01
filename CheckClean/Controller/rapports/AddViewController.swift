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

    @IBOutlet weak var btnImportPicture: UIButton!
    @IBOutlet weak var btnNavCancell: UIBarButtonItem!
    @IBOutlet weak var labelAddReportNameLocal: UILabel!
    @IBOutlet weak var labelAddReportDescription: UILabel!
    @IBOutlet weak var labelAddReportScore: UILabel!
    @IBOutlet weak var btnAddReportCancell: UIButton!
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
        
        labelAddReportNameLocal.text = NSLocalizedString("LABEL_ADD_REPORT_NAME_LOCAL", comment: "")
        labelAddReportDescription.text = NSLocalizedString("LABEL_ADD_REPORT_DESCRIPTION", comment: "")
        labelAddReportScore.text = NSLocalizedString("LABEL_ADD_REPORT_SCORE", comment: "")
        btnNavCancell.title = NSLocalizedString("BTN_CANCEL", comment: "")
        btnImportPicture.setTitle(NSLocalizedString("BTN_RAPPORT_PICTURE_LIBRARY", comment: ""), for: .normal)
        btnAddReportCancell.setTitle(NSLocalizedString("BTN_ADD_TO_REPORT", comment: ""), for: .normal)
        
        desc.layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 0.5).cgColor
        desc.layer.borderWidth = 0.9
        desc.layer.cornerRadius = 10
        self.view.makeToast(NSLocalizedString("TOAST_MESSAGE_FOR_REPORT", comment: ""),
                            duration: 4.0, title: NSLocalizedString("TOAST_MESSAGE_TITLE_REPORT", comment: ""), image: UIImage(named: "attention"), completion: nil)
    }

    
    @IBAction func didChangeRaiting(_ sender: UISlider) {
        
        showToast("\(sender.value.rounded(.down))")
    }
    
    @IBAction func tapClose() {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSendRapport(_ sender: Any) {
        let labTitle = checkInfo(value: local.text!)
        let labDesc = checkInfo(value: desc.text!)
        
        if  labTitle && labDesc{
        
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
       
    }
    
    func showToast(_ message: String) {
        var img = UIImage(named: "bad")
        var title = NSLocalizedString("TOAST_SCORE_SBAD", comment: "")
        switch Double( message) {
        case 1.0:
            img = UIImage.init(named: "sBad")
            title = NSLocalizedString("TOAST_SCORE_SBAD", comment: "")
            break
        case 2.0:
            img = UIImage.init(named: "middle")
            title = NSLocalizedString("TOAST_SCORE_MIDDLE", comment: "")
            break
        case 3.0:
            img = UIImage.init(named: "correct")
            title = NSLocalizedString("TOAST_SCORE_CORRECT", comment: "")
            break
        case 4.0:
            img = UIImage.init(named: "parfait")
            title = NSLocalizedString("TOAST_SCORE_PERFECT", comment: "")
            break
        case 5.0:
            img = UIImage.init(named: "star")
            title = NSLocalizedString("TOAST_SCORE_MORE_PERFECT", comment: "")
            break
        default:
            break
        }
        
        self.view.makeToast("\(NSLocalizedString("LABEL_ADD_REPORT_SCORE", comment: "")) : \(message) / 4.0", duration: 3.0, title: title, image: img, completion: nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkInfo(value: String) -> Bool {
        if value.count == 0 {
            self.view.makeToast(NSLocalizedString("TOAST_MESSAGE_FOR_REPORT_ERROR", comment: ""))
            return false
        }
        return true
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
