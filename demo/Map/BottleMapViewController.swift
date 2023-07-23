//
//  BottleMapViewController.swift
//  demo
//
//  Created by Jessica Liu on 10/17/21.
//

import UIKit
import MapKit
class BottleMapViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private var currentLocation:CLLocationCoordinate2D?
    @IBOutlet private var BottleMapView: MKMapView!
    @IBOutlet weak var recycleButton: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var descriptionText:UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    public var bottlePoints: Int = 0;
    

    private let bottleCenters = [
        recycleCenters(locationName: "Sunset Recycling Center",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude: 34.0533, longitude: -117.95338)),
         recycleCenters(locationName: "JB Recycling",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4:30PM", coordinate: CLLocationCoordinate2D(latitude:34.01754451, longitude:-117.8645622)),
        recycleCenters(locationName: "A 1 Upland Recycling Center",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.09522, longitude:-117.67166)),
        recycleCenters(locationName: "NS Recycling Center",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.1078585, longitude:-117.6629332)),
        recycleCenters(locationName: "Sunset Recycling Center",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.1068222, longitude:-118.06407)),
        recycleCenters(locationName: "Evolution Recycling Inc #2",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.10303657, longitude:-118.09225)),
        recycleCenters(locationName: "Express Cros Interstate Inc",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 4:45PM", coordinate: CLLocationCoordinate2D(latitude:34.07864, longitude:-118.10038)),
        recycleCenters(locationName: "Green Team Recycling Inc",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.07864, longitude:-117.82415)),
        recycleCenters(locationName: "Zhak Inc",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.1030756, longitude:-117.8114796)),
        recycleCenters(locationName: "Evolution Recycling Inc #20",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0626936, longitude:-118.0707601)),
        recycleCenters(locationName: "Ponce Recycling",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0615566, longitude:-117.7856937)),
        recycleCenters(locationName: "Omar Recycling #3",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.10647, longitude:-117.74859)),
        recycleCenters(locationName: "Pomona Recycling",openStore: 10 ,closeStore: 18,statement: "Open From 10AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.062, longitude:-117.71893)),
        recycleCenters(locationName: "Ocho Recycling",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.05585, longitude:-117.73578)),
        recycleCenters(locationName: "Pomona Scrap Metal",openStore: 7 ,closeStore: 17,statement: "Open From 7AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.41788, longitude:-111.79983)),
        recycleCenters(locationName: "Recycling Resources",openStore: 7 ,closeStore: 17,statement: "Open From 7AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0574415, longitude:-117.7654313)),
        recycleCenters(locationName: "Armbar Recycling Inc",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.97354889, longitude:-117.8382568)),
        recycleCenters(locationName: "A & A Recycling",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.04122543, longitude:-117.6510468)),
        recycleCenters(locationName: "NS Recycling Center #2",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.04122543, longitude:-117.6510468)),
        recycleCenters(locationName: "Premises Metals Recycling",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.05394363, longitude:-117.6850891)),
        recycleCenters(locationName: "Cal Green Recycling Center",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0400664, longitude:-117.6511914)),
        recycleCenters(locationName: "W's Metal Recycling Center",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0476592, longitude:-117.6512)),
        recycleCenters(locationName: "Evolution Recycling",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.05358505, longitude:-118.150589)),
        recycleCenters(locationName: "Sunset Recycling Center",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0652205, longitude:-118.1341895)),
        recycleCenters(locationName: "Alfonso Garcia Recycling",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude: 33.98741913, longitude: -117.8879547)),
        recycleCenters(locationName: "Kay-Met Recycling",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.999383, longitude:-117.887397)),
        recycleCenters(locationName: "Medford Recycling",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.986402, longitude:-117.871007)),
        recycleCenters(locationName: "Green Earth Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.021054, longitude:-117.959436)),
        recycleCenters(locationName: "Industry Recycling Chavez",openStore: 8 ,closeStore: 15,statement: "Open From 8AM to 3PM", coordinate: CLLocationCoordinate2D(latitude:34.052286, longitude:-117.988437)),
        recycleCenters(locationName: "NS Recycling",openStore: 8 ,closeStore: 15,statement: "Open From 8AM to 3PM", coordinate: CLLocationCoordinate2D(latitude:34.0528006, longitude:-117.9731885)),
        recycleCenters(locationName: "Great Future Recycling Inc #3",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 7PM", coordinate: CLLocationCoordinate2D(latitude:34.03616714, longitude:-117.9262772)),
        recycleCenters(locationName: "Industry Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0146, longitude:-117.97496)),
        recycleCenters(locationName: "Laur Metals Co",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0342978, longitude:-117.950319)),
        recycleCenters(locationName: "Lima Recycling Center La Puente",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0157064, longitude:-117.9484468)),
        recycleCenters(locationName: "Ponce Recycling",openStore: 8 ,closeStore: 16,statement: "Open From 8AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0615566, longitude:-117.7856937)),
        recycleCenters(locationName: "Sunset Recycling Center",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0342978, longitude:-117.950319)),
        recycleCenters(locationName: "Laur Metals Co",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.0342978, longitude:-117.950319)),
        recycleCenters(locationName: "W's Metal Recycling Center",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.062711, longitude:-118.0600337)),
        recycleCenters(locationName: "16 Street Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0757487, longitude:-118.0088865)),
        recycleCenters(locationName: "Ginas Recycling Center",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0771801, longitude:-118.0213418)),
        recycleCenters(locationName: "Pretty California Clean",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0677773, longitude:-118.0266242)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0982785, longitude:-117.4634893)),
        recycleCenters(locationName: "Aras Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0726108, longitude:-118.0359911)),
        recycleCenters(locationName: "PRC Collection Inc",openStore: 8 ,closeStore: 14,statement: "Open From 8AM to 2PM", coordinate: CLLocationCoordinate2D(latitude:34.0847662, longitude:-117.872595)),
        recycleCenters(locationName: "R Men",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.1067921, longitude:-117.8911047)),
        recycleCenters(locationName: "Milton's Recycling Center",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.105373, longitude:-117.89026)),
        recycleCenters(locationName: "Green Town Recycling #4",openStore: 9 ,closeStore: 16,statement: "Open From 9AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.0188109, longitude:-117.7306266)),
        recycleCenters(locationName: "SA Recycling",openStore: 9 ,closeStore: 17,statement: "Open From 9AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.0073503, longitude:-117.724031)),
        recycleCenters(locationName: "Chino Hills Recycling",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.9839133, longitude:-117.7123681)),
        recycleCenters(locationName: "Allan Co",openStore: 7 ,closeStore: 16,statement: "Open From 7AM to 4PM", coordinate: CLLocationCoordinate2D(latitude:34.1068376, longitude:-117.9575506)),
        recycleCenters(locationName: "Sunset Recycling Center",openStore: 10 ,closeStore: 23,statement: "Open From 10AM to 11PM", coordinate: CLLocationCoordinate2D(latitude:34.06908, longitude:-117.97855)),
        recycleCenters(locationName: "W's Metal Recycling Center",openStore: 9 ,closeStore: 18,statement: "Open From 9AM to 6PM", coordinate: CLLocationCoordinate2D(latitude:34.06716, longitude:-117.99)),
        recycleCenters(locationName: "GG Recycling Center",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:34.10767, longitude:-117.9202)),
        recycleCenters(locationName: "Medford Recycling",openStore: 8 ,closeStore: 17,statement: "Open From 8AM to 5PM", coordinate: CLLocationCoordinate2D(latitude:33.986402, longitude:-117.871007)),


    ]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        
        setUpElement()
        
        BottleMapView.register(
          centerMarkerView.self,
          forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        BottleMapView.delegate=self
        
        for bcenter in bottleCenters {
            BottleMapView.addAnnotation(bcenter)
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
        confirmButton.alpha=1
        recycleButton.alpha=0
    }
    @IBAction func exitTapped(_sender:Any){
        setUpElement()
        recycleButton.alpha=1
    }
    @IBAction func confirmTapped(_sender:Any){
        setUpElement()
        self.view.endEditing(true)
        recycleButton.alpha=1
        
        let input2 = input.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let points = Int(input2)
        bottlePoints = bottlePoints + points!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        destinationVC.bottlePoints = bottlePoints
        
    }
    
    
    private func beginLocationUpdates(locationManager:CLLocationManager){
        BottleMapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000,longitudinalMeters: 15000)
        BottleMapView.setRegion(zoomRegion, animated: true)
        
    }
}

extension BottleMapViewController: CLLocationManagerDelegate{
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

extension BottleMapViewController: MKMapViewDelegate{
    
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

