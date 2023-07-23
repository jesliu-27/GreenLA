//
//  MetalMapViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit
import MapKit


class MetalMapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentLocation:CLLocationCoordinate2D?
    @IBOutlet private var MetalmapView: MKMapView!
    public var MetalPoints = 0;
    @IBOutlet weak var recycleButton: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var descriptionText:UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let metalCenters = [
        
        recycleCenters(locationName: "Atlas Iron & Metal Company, Inc", openStore: 7 ,closeStore: 15,statement: "Open From 7AM to 3PM",coordinate: CLLocationCoordinate2D(latitude:33.895404, longitude:-118.2203331)),
        recycleCenters(locationName: "Kay-Met Recycling",openStore: 7 ,closeStore: 15,statement: "Open From 7AM to 3PM", coordinate: CLLocationCoordinate2D(latitude:33.999383, longitude:-117.887397)),
        recycleCenters(locationName: "Unicorn Metals Recycling", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.92758, longitude:-117.94299)),
        recycleCenters(locationName: "Lima Recycling Center", openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:34.0177445, longitude:-117.9510181)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0677773, longitude:-118.0266242)),
        recycleCenters(locationName: "P&T Metals Inc", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:34.0525409, longitude:-118.0360343)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.1142955, longitude:-117.9828659)),
        recycleCenters(locationName: "Eagle Scrap Metal", openStore: 7 ,closeStore: 17,statement: "Open From 7AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.8625086, longitude:-117.8762977)),
        recycleCenters(locationName: "DBW Metals Recycling", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.8478825, longitude:-117.8525941)),
        recycleCenters(locationName: "Breiter Metals", openStore: 7 ,closeStore: 15,statement: "Open From 7AM to 3PM",coordinate: CLLocationCoordinate2D(latitude:33.858834, longitude:-117.8736973)),
        recycleCenters(locationName: "All-Met Recycling Inc", openStore: 7 ,closeStore: 15,statement: "Open From 7AM to 3PM",coordinate: CLLocationCoordinate2D(latitude:33.865892, longitude:-117.8512705)),
        recycleCenters(locationName: "Rodriguez Scrap Metal", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.86831415, longitude:-117.9112951)),
        recycleCenters(locationName: "Asco Metals", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.9550325, longitude:-118.0677873)),
        recycleCenters(locationName: "General Metal Recycling Co.", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.9918538, longitude:-118.1115081)),
        recycleCenters(locationName: "Star Scrap Metal Co Inc", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.980989, longitude:-118.117346)),
        recycleCenters(locationName: "Sunset Recycling Center", openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0533633, longitude:-117.9534253)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.8478825, longitude:-117.8525941)),
        recycleCenters(locationName: "Vi-Cal Metals Inc.", openStore: 8 ,closeStore: 14,statement: "Open From 8AM to 2PM", coordinate: CLLocationCoordinate2D(latitude:33.8545487, longitude:-117.8936666)),
        recycleCenters(locationName: "Global Metal Recycling Inc",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:33.743494, longitude:-117.8596198)),
        recycleCenters(locationName: "SunWest Metals, Inc.", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.8371022, longitude:-117.914475)),
        recycleCenters(locationName: "D & T Recycling (Scrap Metals & CRV)", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.8984637, longitude:-118.168843)),
        recycleCenters(locationName: "Orange County Scrap", openStore: 5 ,closeStore: 17,statement: "Open From 5AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.8293259, longitude:-117.8997611)),
        recycleCenters(locationName: "Industry Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0146, longitude:-117.97496)),
        recycleCenters(locationName: "Garcia Recycling & Metals", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.761215, longitude:-117.9226397)),
        recycleCenters(locationName: "Bruce Metal & Salvage Inc", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.7497229, longitude:-117.8643482)),
        recycleCenters(locationName: "C & M Metals", openStore: 6 ,closeStore: 17,statement: "Open From 6AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.016281, longitude:-118.2280353)),
        recycleCenters(locationName: "Ekco Metals", openStore: 7 ,closeStore: 15,statement: "Open From 7AM to 3PM", coordinate: CLLocationCoordinate2D(latitude:34.0173549, longitude:-118.2225616)),
        recycleCenters(locationName: "Downtown Metals & Recycling Center", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:34.0153644, longitude:-118.2395956)),
        recycleCenters(locationName: "A & M Metals, Inc.",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:33.7487773, longitude:-117.9326224)),
        recycleCenters(locationName: "Universal Scrap Metal Recycling", openStore: 7 ,closeStore: 16,statement: "Open From 7AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0165929, longitude:-118.20948)),
        recycleCenters(locationName: "A & S Metals Recycling", openStore: 7 ,closeStore: 16,statement: "Open From 7AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:34.02149582, longitude:-118.2313843)),
        recycleCenters(locationName: "Socal Metals Inc", openStore: 7 ,closeStore: 16,statement: "Open From 7AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.98682, longitude:-118.13076)),
        recycleCenters(locationName: "Sackin Metals", openStore: 7 ,closeStore: 15,statement: "Open From 7AM to 3PM",coordinate: CLLocationCoordinate2D(latitude:33.7410073, longitude:-118.0260307)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.7486944, longitude:-117.8933035)),
        recycleCenters(locationName: "W'S Metal Recycling Center", openStore: 7 ,closeStore: 17,statement: "Open From 7AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.99297, longitude:-118.24258)),
        recycleCenters(locationName: "los Angeles Scrap metal buyers", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM",coordinate: CLLocationCoordinate2D(latitude:33.98071, longitude:-118.26299)),
        recycleCenters(locationName: "Washington Metal Recycling", openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:33.9895668, longitude:-118.25342)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.02208328, longitude:-118.2337418)),
        recycleCenters(locationName: "Figueroa Metal Recycling", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.9463656, longitude:-118.28201)),
        recycleCenters(locationName: "Junk King Los Angeles", openStore: 3 ,closeStore: 19,statement: "Open From 3AM to 7PM",coordinate: CLLocationCoordinate2D(latitude:34.0282137, longitude:-118.0398953)),


        
    ]



    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        setUpElement()
        
        MetalmapView.register(
          centerMarkerView.self,
          forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)

        
        MetalmapView.delegate=self
        
        for metalcenter in metalCenters{
            MetalmapView.addAnnotation(metalcenter)
        }


        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
        private func configureLocationServices(){
        locationManager.delegate=self
        
        let status = CLLocationManager.authorizationStatus()
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        
        else if status == .authorizedAlways {
            beginLocationUpdates(locationManager: locationManager)        }
        
        else if status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func setUpElement(){
        input.alpha = 0
        descriptionText.alpha = 0
        exitButton.alpha=0
        confirmButton.alpha=0
    }
    
    @IBAction func recycleButtonTapped(_sender:Any){
        input.alpha=1
        descriptionText.alpha = 1
        exitButton.alpha=1
        recycleButton.alpha=0
        confirmButton.alpha=1
    }
    @IBAction func exitTapped(_sender:Any){
        setUpElement()
        recycleButton.alpha=1
    }
    @IBAction func confirmTapped(_sender:Any){
        setUpElement()
        recycleButton.alpha=1
        self.view.endEditing(true)
    }
    
    
    private func beginLocationUpdates(locationManager:CLLocationManager){
        MetalmapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000,longitudinalMeters: 15000)
        MetalmapView.setRegion(zoomRegion, animated: true)
        
    }
}

extension MetalMapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        
        guard let latestLocation = locations.first else {return}
        
        if currentLocation == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        currentLocation = latestLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("The status changed")
        
        if status == .authorizedAlways{
            beginLocationUpdates(locationManager: manager)
        }
        else if status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: manager)
        }
    }
    
}

extension MetalMapViewController: MKMapViewDelegate{
    
    func MetalmapView(
      _ mapView: MKMapView,
      annotationView view: MKAnnotationView,
      calloutAccessoryControlTapped control: UIControl
    ) {
      guard let centers = view.annotation as? recycleCenters else {
        return
      }

      let launchMap = [
        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
      ]
      centers.mapItem?.openInMaps(launchOptions: launchMap)
    }

}

