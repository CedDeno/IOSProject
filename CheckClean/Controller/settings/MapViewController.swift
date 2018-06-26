//
//  MapViewController.swift
//  CheckClean
//
//  Created by Machado Sergio on 22/06/18.
//  Copyright © 2018 Machado Sergio. All rights reserved.
//

import UIKit
import MapKit
import Toast_Swift

class MapViewController: UIViewController, MKMapViewDelegate {

    var findadress = false
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let adddress  = UserDefaults.standard.string(forKey: "BuldingAddress")
        let name = UserDefaults.standard.string(forKey: "BuldingName")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adddress!) { (placemarker, error) in
            
            if error == nil {
                self.findadress = true
                if let place = placemarker?.first {
                    let coordi:  CLLocationCoordinate2D  = (place.location?.coordinate)!
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordi
                    annotation.title = name!
                    
                    let region = MKCoordinateRegion(center: coordi, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01))
                
                    self.myMap.addAnnotation(annotation)
                    self.myMap.setRegion(region, animated: true)
                }
            }
            if self.findadress {
               self.view.makeToast("Error mauvzis addres")
            }
        }
    }
}
