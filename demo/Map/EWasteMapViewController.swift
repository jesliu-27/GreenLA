//
//  EWasteMapViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit
import MapKit

class EWMapViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private var currentLocation:CLLocationCoordinate2D?
    @IBOutlet private var EWmapView: MKMapView!
    public var EWPoints = 0;
    @IBOutlet weak var recycleButton: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var descriptionText:UITextField!
    @IBOutlet weak var confirmButton:UIButton!
    
    private let ewasteCenters = [
        
        recycleCenters(locationName: "Veolia ES Technical Solutions, LLC (Azusa)",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude: 34.12158, longitude: -117.93669)),
         
        recycleCenters(locationName: "3 Way Thrift Store, Inc.",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude: 34.01112, longitude: -117.68997)),
         
        recycleCenters(locationName: "Attan Recycling, Corp.",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude: 34.00068, longitude:-117.70976)),
         
         
        recycleCenters(locationName: "Secure EWaste Management, Inc",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:33.9973341, longitude:-117.6803717)),
        recycleCenters(locationName: "USA Waste of California (Chino)",openStore: 7,closeStore: 17,statement: "Open From 7AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.00283, longitude:-117.68625)),
        recycleCenters(locationName: "West Coast Computer Recycler",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0706705, longitude:-118.0543381)),
        recycleCenters(locationName: "Recycle International",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0633738, longitude:-118.0116452)),
        recycleCenters(locationName: "Computer Recycling Team, Inc.",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0478154, longitude:-118.0384634)),
        recycleCenters(locationName: "Grand Central Recycling & Transfer Station, Inc.",openStore: 6 ,closeStore: 17,statement: "Open From 6AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0033838891722, longitude:-117.923272916148)),
        recycleCenters(locationName: "Kay-Met Recycling",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.999383, longitude:-117.887397)),
        recycleCenters(locationName: "Cal Micro Recycling",openStore: 8 ,closeStore: 15,statement: "Open From 8AM to 3PM", coordinate: CLLocationCoordinate2D(latitude:34.0623553, longitude:-117.6624699)),
        recycleCenters(locationName: "Heroes Deserve Help",openStore: 6 ,closeStore: 0,statement: "Open From 6AM to 12PM", coordinate: CLLocationCoordinate2D(latitude:34.103153, longitude:-117.816055)),

        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        setUpElement()
        
        EWmapView.register(
          centerMarkerView.self,
          forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)

        
        EWmapView.delegate=self
        
        for ecenter in ewasteCenters{
            EWmapView.addAnnotation(ecenter)
        }
        
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
        EWmapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000,longitudinalMeters: 15000)
        EWmapView.setRegion(zoomRegion, animated: true)
        
    }
}

extension EWMapViewController: CLLocationManagerDelegate{
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

extension EWMapViewController: MKMapViewDelegate{
    
    func mapView(
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


