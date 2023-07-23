//
//  MOMapViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit
import MapKit

class MOMapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentLocation:CLLocationCoordinate2D?
    @IBOutlet private var MOmapView: MKMapView!
    public var MOPoints = 0;
    @IBOutlet weak var recycleButton: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var descriptionText:UITextField!
    @IBOutlet weak var confirmButton:UIButton!

    private let motorCenters = [
        recycleCenters(locationName: "AutoZone #5228",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0342978, longitude:-117.950319)),
        recycleCenters(locationName: "Consumer Auto Center",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.00642, longitude:-117.90731)),
        recycleCenters(locationName: "Jiffy Lube #1518",openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.03776, longitude:-117.94983)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3607",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.04245, longitude:-117.949378)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3076",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.01033, longitude:-117.96124)),
        recycleCenters(locationName: "AutoZone #5393",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.01479, longitude:-117.9754)),
        recycleCenters(locationName: "Four Season Bus Specialist",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.02182, longitude:-117.98073)),
        recycleCenters(locationName: "Top Lube, Inc.",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.05286, longitude:-117.97335)),
        recycleCenters(locationName: "Ed Butts Ford",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.04752, longitude:-117.94839)),
        recycleCenters(locationName: "Diamond Honda",openStore: 7 ,closeStore: 21,statement: "Open From 7AM to 9PM", coordinate: CLLocationCoordinate2D(latitude:33.99763, longitude:-117.92381)),
        recycleCenters(locationName: "Puente Hills Toyota-Scion",openStore: 7 ,closeStore: 21,statement: "Open From 7AM to 9PM", coordinate: CLLocationCoordinate2D(latitude:34.00059, longitude:-117.93481)),
        recycleCenters(locationName: "Pep Boys Store #1404",openStore: 8 ,closeStore: 18, statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:33.99018, longitude:-117.91696)),
        recycleCenters(locationName: "Mountain View Tire/Goodyear", openStore: 8 ,closeStore: 17, statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.98821, longitude:-117.89313)),
        recycleCenters(locationName: "Puente Hills Nissan",openStore: 7 ,closeStore: 18, statement: "Open From 7AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:33.9977, longitude:-117.92781)),
        recycleCenters(locationName: "Puente Hills Ford", openStore: 9 ,closeStore: 21, statement: "Open From 9AM to 9PM",coordinate: CLLocationCoordinate2D(latitude:33.99684, longitude:-117.92616)),
        recycleCenters(locationName: "Puente Hills Mazda", openStore: 10 ,closeStore: 19, statement: "Open From 10AM to 7PM",coordinate: CLLocationCoordinate2D(latitude:33.99568, longitude:-117.9186)),
        recycleCenters(locationName: "Puente Hills Subaru", openStore: 9 ,closeStore: 21, statement: "Open From 9AM to 9PM",coordinate: CLLocationCoordinate2D(latitude:33.99615, longitude:-117.91705)),
        recycleCenters(locationName: "Puente Hills Chevrolet", openStore: 7 ,closeStore: 21, statement: "Open From 7AM to 9PM",coordinate: CLLocationCoordinate2D(latitude:33.99868, longitude:-117.92842)),
         
        recycleCenters(locationName: "Mountain View Tire and Auto Service", openStore: 8 ,closeStore: 17, statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:33.98821, longitude:-117.89313)),
        recycleCenters(locationName: "Jaguar Land Rover Puente Hills", openStore: 7 ,closeStore: 18, statement: "Open From 7AM to 6PM",coordinate: CLLocationCoordinate2D(latitude:33.995886, longitude:-117.920236)),
        recycleCenters(locationName: "Quickies Oil Change", openStore: 8 ,closeStore: 17, statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:34.12096, longitude:-117.78877)),
        recycleCenters(locationName: "La Verne Tire / Firestone", openStore: 8 ,closeStore: 17, statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:34.1022, longitude:-117.77124)),
        recycleCenters(locationName: "AutoZone #5398",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.117, longitude:-117.77636)),
        recycleCenters(locationName: "Silver Star Services", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.06223, longitude:-118.13098)),
        recycleCenters(locationName: "Vo Auto Repair", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:34.06949, longitude:-118.12293)),
        recycleCenters(locationName: "Camino Real Chevrolet", openStore: 9 ,closeStore: 20,statement: "Open From 9AM to 8PM",coordinate: CLLocationCoordinate2D(latitude:34.03644, longitude:-118.14911)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3206",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.07387, longitude:-117.66955)),
        recycleCenters(locationName: "AutoZone #5617",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.039762, longitude:-117.65106)),
        recycleCenters(locationName: "AutoZone #3328",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0771, longitude:-117.6701)),
        recycleCenters(locationName: "Firestone Store #015768", openStore: 7 ,closeStore: 18,statement: "Open From 7AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.08655, longitude:-117.68946)),
        recycleCenters(locationName: "Pep Boys #730", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.093, longitude:-117.693)),
        recycleCenters(locationName: "O’Reilly Auto Parts #2907",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.06326, longitude:-117.71718)),
        recycleCenters(locationName: "AutoZone #5616",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.06314681, longitude:-117.6922059)),
        recycleCenters(locationName: "AutoZone #4002",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0734827, longitude:-117.6894947)),
        recycleCenters(locationName: "Metro Honda",openStore: 7 ,closeStore: 21,statement: "Open From 7AM to 9PM", coordinate: CLLocationCoordinate2D(latitude:34.08315, longitude:-117.69377)),
        recycleCenters(locationName: "Metro Nissan of Montclair",openStore: 9 ,closeStore: 20,statement: "Open From 9AM to 8PM", coordinate: CLLocationCoordinate2D(latitude:34.08229, longitude:-117.69483)),
        recycleCenters(locationName: "Firestone Store #025984", openStore: 7 ,closeStore: 18,statement: "Open From 7AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.00144, longitude:-117.81204)),
        recycleCenters(locationName: "AutoZone #5373", openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.02005, longitude:-117.80945)),
        recycleCenters(locationName: "Grand Mobil", openStore: 24 ,closeStore: 24,statement: "Open 24 hours", coordinate: CLLocationCoordinate2D(latitude:34.00656, longitude:-117.8213)),
        recycleCenters(locationName: "Tire Choice", openStore: 7 ,closeStore: 18,statement: "Open From 7AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.003436, longitude:-117.8097819)),
        recycleCenters(locationName: "AutoZone #2846",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.03727, longitude:-117.74935)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3499",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0404735, longitude:-117.7494902)),
        recycleCenters(locationName: "All Star Kia Pomona", openStore: 9 ,closeStore: 21,statement: "Open From 9AM to 9PM",coordinate: CLLocationCoordinate2D(latitude:34.033242, longitude:-117.7512923)),
        recycleCenters(locationName: "Pep Boys #616", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0628847, longitude:-117.7290434)),
        recycleCenters(locationName: "Jiffy Lube #1200",openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0774087, longitude:-117.7523016)),
        recycleCenters(locationName: "AutoZone #5469",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0628847, longitude:-117.7290434)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3167",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.1069856, longitude:-117.746965)),
        recycleCenters(locationName: "AutoZone #2883",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0602303, longitude:-117.7414843)),
        recycleCenters(locationName: "Pep Boys Store #1439", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.107482, longitude:-117.7475092)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3031",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0615566, longitude:-117.7856937)),
        recycleCenters(locationName: "AutoZone #5475",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0812662, longitude:-118.0580093)),
        recycleCenters(locationName: "AutoZone #5476",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.06244, longitude:-118.08656)),
        recycleCenters(locationName: "City Tech Auto Repair", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM",coordinate: CLLocationCoordinate2D(latitude:34.0626936, longitude:-118.0707601)),
        recycleCenters(locationName: "Lima Auto Repair", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:34.0671608, longitude:-118.0698414)),
        recycleCenters(locationName: "Jiffy Lube #2224",openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0812662, longitude:-118.0580093)),
        recycleCenters(locationName: "Valvoline Instant Oil Change IH0171", openStore: 7 ,closeStore: 19,statement: "Open From 7AM to 7PM", coordinate: CLLocationCoordinate2D(latitude:34.0671608, longitude:-118.0698414)),
        recycleCenters(locationName: "AutoZone #6055",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.1060194, longitude:-117.8195167)),
        recycleCenters(locationName: "Tire Choice", openStore: 7 ,closeStore: 18,statement: "Open From 7AM to 6PM",coordinate: CLLocationCoordinate2D(latitude:34.1067272, longitude:-117.8122864)),
        recycleCenters(locationName: "Pep Boys #836", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0984731, longitude:-118.0743766)),
        recycleCenters(locationName: "Mission Express Lube", openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM",coordinate: CLLocationCoordinate2D(latitude:34.0911293, longitude:-118.0907421)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3153",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.10350316, longitude:-118.0867484)),
        recycleCenters(locationName: "AutoZone #5463",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.1014464, longitude:-118.073603)),
        recycleCenters(locationName: "Valvoline Instant Oil Change GN-0026", openStore: 7 ,closeStore: 19,statement: "Open From 7AM to 7PM",coordinate: CLLocationCoordinate2D(latitude:34.1030084, longitude:-118.0732662)),
        recycleCenters(locationName: "AutoZone #5635",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.1070804, longitude:-117.6464268)),
        recycleCenters(locationName: "O'Reilly Auto Parts #3974", openStore: 7 ,closeStore: 21,statement: "Open From 7AM to 9PM",coordinate: CLLocationCoordinate2D(latitude:34.1067342, longitude:-117.6969069)),
        recycleCenters(locationName: "Ford of Upland", openStore: 10 ,closeStore: 18,statement: "Open From 10AM to 6PM",coordinate: CLLocationCoordinate2D(latitude:34.106995, longitude:-117.65799)),
        recycleCenters(locationName: "Jiffy Lube #1876",openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.106857, longitude:-117.682884)),
        recycleCenters(locationName: "Pep Boys #960", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.1067342, longitude:-117.6969069)),
        recycleCenters(locationName: "Firestone Store #006378", openStore: 7 ,closeStore: 18,statement: "Open From 7AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.02604593, longitude:-117.8950291)),
        recycleCenters(locationName: "O’Reilly Auto Parts #3039",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0355399, longitude:-117.8741022)),
        recycleCenters(locationName: "Pep Boys Store #1409", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0667422, longitude:-117.9272355)),
        recycleCenters(locationName: "AutoZone #5369",openStore: 7 ,closeStore: 22,statement: "Open From 7AM to 10PM", coordinate: CLLocationCoordinate2D(latitude:34.0809011, longitude:-117.9078463)),
        recycleCenters(locationName: "Crestview Cadillac",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0710517, longitude:-117.8806867)),
        recycleCenters(locationName: "Valvoline Instant Oil Change GN-0065", openStore: 7 ,closeStore: 19,statement: "Open From 7AM to 7PM", coordinate: CLLocationCoordinate2D(latitude:34.07450683, longitude:-117.8899182)),
        recycleCenters(locationName: "Ford of West Covina", openStore: 9,closeStore: 21,statement: "Open From 9AM to 9PM",coordinate: CLLocationCoordinate2D(latitude:34.0710517, longitude:-117.8806867)),
        recycleCenters(locationName: "Pep Boys #676", openStore: 8 ,closeStore: 18,statement: "Open From 8AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.029773, longitude:-117.9125391)),

        
            ]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        
        setUpElement()
        
        MOmapView.register(
          centerMarkerView.self,
          forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        MOmapView.delegate=self
        
                
              
        for mcenter in motorCenters{
            MOmapView.addAnnotation(mcenter)
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
        MOmapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000,longitudinalMeters: 15000)
        MOmapView.setRegion(zoomRegion, animated: true)
        
    }
}

extension MOMapViewController: CLLocationManagerDelegate{
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

extension MOMapViewController: MKMapViewDelegate{
        
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

