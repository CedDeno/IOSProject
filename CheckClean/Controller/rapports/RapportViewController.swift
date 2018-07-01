//
//  RapportViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 15/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import MessageUI
import Toast_Swift
import SimplePDF

class RapportViewController: UIViewController {

    var buldingName: String = ""
    
    @IBOutlet weak var labelReportComment: UILabel!
    @IBOutlet weak var labelReportSubjet: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imageRapport: UIImageView!
    @IBOutlet weak var textComment: UITextView!
    @IBOutlet weak var textSujet: UITextField!
    @IBOutlet weak var btnAddPicture: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        buldingName = UserDefaults.standard.string(forKey: "BuldingName")!
        labelReportSubjet.text = NSLocalizedString("LABEL_RAPPORT_SUBJET", comment: "")
        labelReportComment.text = NSLocalizedString("LABEL_RAPPORT_COMMENT", comment: "")
        textSujet.placeholder = NSLocalizedString("PLACEHOLDER_REPORT_SUBJET", comment: "")
        btnSend.setTitle(NSLocalizedString("BTN_SEND", comment: ""), for: .normal)
        btnSend.backgroundColor = UIColor(cgColor: ColorNav().getColorButton())
        btnAddPicture.setTitle(NSLocalizedString("BTN_RAPPORT_PICTURE_LIBRARY", comment: ""), for: .normal)
        btnAddPicture.backgroundColor = UIColor(cgColor: ColorNav().getColorButton())
        
    }
    
    @IBAction func btnTakePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePiker = UIImagePickerController()
            imagePiker.delegate = self
            imagePiker.sourceType = .camera
            imagePiker.allowsEditing = false
            imagePiker.modalTransitionStyle = .flipHorizontal
            self.present(imagePiker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAddPicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePiker = UIImagePickerController()
            imagePiker.delegate = self
            imagePiker.sourceType = .photoLibrary
            imagePiker.allowsEditing = false
            imagePiker.modalTransitionStyle = .flipHorizontal
            self.present(imagePiker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnSend(_ sender: Any) {
        if let tSujet = textSujet.text, let tCommt = textComment.text {
            if !tSujet.isEmpty && !tCommt.isEmpty {
                
                let date = Date()
                let dateformat = DateFormatter()
                dateformat.dateFormat = "dd.MM.yyyy"
                
                let A4paperSize = CGSize(width: 595, height: 842)
                let pdf = SimplePDF(pageSize: A4paperSize)
                let uiimage = UIImage(named: "logo")
                let myimage = uiimage?.resized(withPercentage: 0.10)
                pdf.setContentAlignment(.right)
                pdf.addImage(myimage!)
                pdf.addText("CheckClean", font: UIFont(name: "Dopestyle", size: CGFloat(30))!, textColor: UIColor.blue)
                pdf.addText(dateformat.string(from: date))
                pdf.setContentAlignment(.left)
                pdf.addLineSpace(CGFloat(20))
                pdf.addText(buldingName)
                pdf.addLineSpace(CGFloat(20))
                pdf.addText(tSujet)
                pdf.addLineSpace(CGFloat(30))
                pdf.addText(tCommt)
                pdf.addLineSpace(CGFloat(30))
                
                if imageRapport.image != nil {
                    let img = imageRapport.image!.resized(withPercentage: 0.10)
                    pdf.addImage(img!)
                }
                let dataPdf = pdf.generatePDFdata()
                let activityViewController = UIActivityViewController(activityItems: [dataPdf], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
                self.present(activityViewController, animated: true, completion: nil)
                
            } else {
                self.view.makeToast(NSLocalizedString("TOAST_REPORT_ERROR", comment: ""))
            }
    }
    }
}
extension RapportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageRapport.image = img
        dismiss(animated: true, completion: nil)
    }
}
