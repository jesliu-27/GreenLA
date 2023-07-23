//
//  centers.swift
//  Keep Recycle And Carry On
//
//  Created by Jessica Liu on 10/10/21.
//


import Foundation
import MapKit
import Contacts

class recycleCenters: NSObject, MKAnnotation {
  let title: String?
  let openStore: Int
  let closeStore: Int
  let statment: String?
  let coordinate: CLLocationCoordinate2D

  init(
    locationName: String?,
    openStore:Int?,
    closeStore:Int?,
    statement: String?,
    coordinate: CLLocationCoordinate2D
    
  ) {
    
    self.title = locationName
    self.openStore = openStore!
    self.closeStore = closeStore!
    self.statment = statement
    self.coordinate = coordinate

    super.init()
  }

  var subtitle: String? {
    return statment
  }
    var markerTintColor: UIColor{
        let hour = Calendar.current.component(.hour, from: Date())
        if openStore == closeStore {
            return .red
        }
        if hour>=openStore && hour<closeStore{
            return .red
        }
        else{
            return .gray
        }
    }
    var mapItem: MKMapItem? {
      guard let location = title else {
        return nil
      }

      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(
        coordinate: coordinate,
        addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
}
