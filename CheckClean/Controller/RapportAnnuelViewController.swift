//
//  RapportAnnuelViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 31/05/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import SimplePDF

class RapportAnnuelViewController: UIViewController {
    
    var messageController: MFMailComposeViewController!
    var zoneRouge: Float = 0.0
    var zonneBleu: Float = 0.0
    var numZoneRouge = 0
    var numZOneBlue = 0
    
    
    var myRapport: [String:[ZoneControl]]!
    var buldin: Bulding!
    var idbulding: String!
    var ref: DatabaseReference!
    var numOffices: Float!
    var numOpenOffice: Float!
    var numMeettingRoom: Float!
    var numRelaxroom: Float!
    var numKitchenette: Float!
    var numRestaurant: Float!
    var numShowers: Float!
    var numWc:  Float!
    var numParking: Float!
    var numcheckTOdo: Int = 0
    var numcheckDid: Int = 0
    

    @IBOutlet weak var progressOffice: UIProgressView!
    @IBOutlet weak var progressOpenspace: UIProgressView!
    @IBOutlet weak var progressMeettingroom: UIProgressView!
    @IBOutlet weak var progressRelaxingroom: UIProgressView!
    @IBOutlet weak var progressKitchinette: UIProgressView!
    @IBOutlet weak var progressRestaurant: UIProgressView!
    @IBOutlet weak var progressWc: UIProgressView!
    @IBOutlet weak var progressParking: UIProgressView!
    @IBOutlet weak var progressShower: UIProgressView!
    
    @IBOutlet weak var office: UIButton!
    @IBOutlet weak var openspace: UIButton!
    @IBOutlet weak var meettingroom: UIButton!
    @IBOutlet weak var relaxroom: UIButton!
    @IBOutlet weak var kitchenette: UIButton!
    @IBOutlet weak var restaurant: UIButton!
    @IBOutlet weak var douche: UIButton!
    @IBOutlet weak var wc: UIButton!
    @IBOutlet weak var parking: UIButton!
    @IBOutlet weak var btnSendRapport: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myRapport = [String:[ZoneControl]]()
        btnSendRapport.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        numcheckTOdo = 0
        zoneRouge = 0
        zonneBleu = 0
        numZOneBlue = 0
        numZoneRouge = 0
        
        self.ref = Database.database().reference(withPath: "BuldingStruct")
        ref.queryOrderedByKey().queryEqual(toValue: idbulding).observe(.value) { (data) in
            
            for item in data.children {
                
                let bulding = item as! DataSnapshot
                
                self.numKitchenette = Float( (bulding.childSnapshot(forPath: "kitchinettes").value as? String)!)
                self.numOffices = Float( (bulding.childSnapshot(forPath: "offices").value as? String)!)
                self.numParking = Float( (bulding.childSnapshot(forPath: "parking").value as? String)!)
                self.numShowers = Float ( (bulding.childSnapshot(forPath: "showers").value as? String)! )
                self.numOpenOffice = Float( (bulding.childSnapshot(forPath: "openSpace").value as? String)!)
                self.numWc = Float( (bulding.childSnapshot(forPath: "wc").value as? String)!)
                self.numRelaxroom = Float( (bulding.childSnapshot(forPath: "relaxingSpace").value as? String)!)
                self.numRestaurant = Float( (bulding.childSnapshot(forPath: "restaurant").value as? String)!)
                self.numMeettingRoom = Float( (bulding.childSnapshot(forPath: "mettingRoom").value as? String)!)
                
                self.knowTOdoCheck(num: self.numKitchenette / 10)
                 self.knowTOdoCheck(num: self.numOffices / 10)
                 self.knowTOdoCheck(num: self.numParking / 10)
                 self.knowTOdoCheck(num: self.numShowers / 10)
                 self.knowTOdoCheck(num: self.numOpenOffice / 10)
                 self.knowTOdoCheck(num: self.numWc / 10)
                 self.knowTOdoCheck(num: self.numRelaxroom / 10)
                 self.knowTOdoCheck(num: self.numRestaurant / 10)
                 self.knowTOdoCheck(num: self.numMeettingRoom / 10)
                
                
                if self.numOffices == 0  {
                    self.progressOffice.setProgress(1, animated: true)
                    self.office.isEnabled = false
                }
                if self.numOpenOffice == 0 {
                    self.progressOpenspace.setProgress(1, animated: true)
                    self.openspace.isEnabled = false
                }
                if self.numMeettingRoom == 0 {
                    self.progressMeettingroom.setProgress(1, animated: true)
                    self.meettingroom.isEnabled = false
                }
                if self.numRelaxroom == 0 {
                    self.progressRelaxingroom.setProgress(1, animated: true)
                    self.relaxroom.isEnabled = false
                }
                if self.numKitchenette == 0 {
                    self.progressKitchinette.setProgress(1, animated: true)
                    self.kitchenette.isEnabled = false
                }
                if self.numShowers == 0 {
                    self.progressShower.setProgress(1, animated: true)
                    self.douche.isEnabled = false
                }
                if self.numWc == 0 {
                    self.progressWc.setProgress(1, animated: true)
                    self.wc.isEnabled = false
                }
                if self.numRestaurant == 0 {
                    self.progressRestaurant.setProgress(1, animated: true)
                    self.restaurant.isEnabled = false
                }
                if self.numParking == 0  {
                    self.progressParking.setProgress(1, animated: true)
                    self.parking.isEnabled = false
                }
                
            }
        }
    }
   
    @IBAction func btn(_ sender: UIButton) {
       
        switch sender {
        case office:
            makeRowRapport(localname: office, progressBar: progressOffice, type: office, pourcent: numOffices)
           
            break
            
        case openspace:
            makeRowRapport(localname: openspace, progressBar: progressOpenspace, type: openspace, pourcent: numOpenOffice)
            break
            
        case meettingroom:
            makeRowRapport(localname: meettingroom, progressBar: progressMeettingroom, type: meettingroom, pourcent: numMeettingRoom)
            break
        
        case relaxroom:
            makeRowRapport(localname: relaxroom, progressBar: progressRelaxingroom, type: relaxroom, pourcent: numRelaxroom)
            break
        
        case kitchenette:
            makeRowRapport(localname: kitchenette, progressBar: progressKitchinette, type: kitchenette, pourcent: numKitchenette)
            break
            
        case restaurant:
            makeRowRapport(localname: restaurant, progressBar: progressRestaurant, type: restaurant, pourcent: numRestaurant)
            break
            
        case douche:
            makeRowRapport(localname: douche, progressBar: progressShower, type: douche, pourcent: numShowers)
            break
            
        case self.wc:
            makeRowRapport(localname: self.wc, progressBar: progressWc, type: self.wc, pourcent: numWc)
            break
            
        case parking:
            makeRowRapport(localname: parking, progressBar: progressParking, type: parking, pourcent: numParking)
            break
            
        default: break
            
        }
    }
    func knowTOdoCheck(num: Float)  {
        
        if  num >= 1 {
           numcheckTOdo = numcheckTOdo + Int(num)
        }else if num >= 0.5 {
            numcheckTOdo = numcheckTOdo + 2
        } else if num >= 0.1 {
            numcheckTOdo = numcheckTOdo + 1
        }
    }
    
    func makeRowRapport(localname:UIButton, progressBar: UIProgressView, type: UIButton, pourcent: Float) {
        
        let numCheck = (pourcent/10)
        if  numCheck >= 1 {
            let progress =  progressBar.progress + (1/numCheck.rounded(.down))
                progressBar.setProgress(progress, animated: true)
        }else if numCheck >= 0.5 {
            let progress =  progressBar.progress + (1/2)
            progressBar.setProgress(progress, animated: true)
        } else {
            let progress =  progressBar.progress + 1
            progressBar.setProgress(progress, animated: true)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        view.delegat = self
        view.localName = localname.currentTitle
        view.button = localname
        view.progressBar = progressBar
        
        self.navigationController?.present(view, animated: true, completion: nil)
    }

    @IBAction func sendRapport(_ sender: Any) {
        
        if numcheckDid == numcheckTOdo {
            
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
            pdf.addText(buldin.name!)
            pdf.addLineSpace(CGFloat(20))
            
            for (key,item) in myRapport {
                
                pdf.addLineSpace(CGFloat(20))
                pdf.addText(key)
                pdf.addLineSpace(CGFloat(20))
                for local in item {
                    pdf.addText(local.title)
                    pdf.addLineSpace(CGFloat(20))
                    pdf.addText(local.description)
                    
                    if let nameK = kitchenette.currentTitle, let nameW = self.wc.currentTitle, let nameR = restaurant.currentTitle, let nameD = douche.currentTitle{
                        if key == nameK || key == nameW || key == nameR || key == nameD {
                            self.zoneRouge = zoneRouge + local.rating
                            numZoneRouge = numZoneRouge + 1
                        } else {
                            self.zonneBleu = zonneBleu + local.rating
                            numZOneBlue = numZOneBlue + 1
                        }
                    }
                    pdf.addText(String(local.rating))
                    
                    if (local.tabImage?.count)! > 0 {
                        if let imgs = local.tabImage {
                            pdf.addLineSpace(CGFloat(20))
                            for img in imgs {
                                let imgsize = img.resized(toWidth: 100.0)
                                pdf.addImage(imgsize!)
                                pdf.addLineSpace(CGFloat(20))
                            }
                        }
                    }
                    pdf.addLineSeparator()
                    pdf.addLineSpace(CGFloat(20))
                }
            }
            
            
            let r = numZoneRouge * 4
            let b = numZOneBlue * 4
            
            let p = ( (zoneRouge * 100 ) / Float( r) ) * 0.6
            let z = ( (zonneBleu * 100 ) / Float( b) ) * 0.4
            pdf.addText("pourcentage \(p + z)", font: UIFont(name: "Bright-Script-Clean", size: CGFloat(20))!, textColor: UIColor.blue)
            
            let pdfData = pdf.generatePDFdata()
            
            ref = Database.database().reference(withPath: "Controls-Bulding")
            let idControl = ref.childByAutoId().key
            let info = [
                "note" : Float(p + z),
                "date" : dateformat.string(from: date)
                ] as [String : Any]
            ref.child(buldin.id).child(idControl).setValue(info)
            
            let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            self.present(activityViewController, animated: true, completion: nil)
            
        }
    }
    
}
extension RapportAnnuelViewController: AddInfoRapport {
    func add(local: String, zone: ZoneControl, button: UIButton, progressBar: UIProgressView) {
        
        if progressBar.progress == 1 {
            button.isEnabled = false
        }
        
        if myRapport.keys.contains(local) {
            myRapport[local]?.append(zone)
        } else {
            myRapport[local] = [zone]
        }
        numcheckDid = numcheckDid + 1
        
        if numcheckDid == numcheckTOdo {
            btnSendRapport.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension RapportAnnuelViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
