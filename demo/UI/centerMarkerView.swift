//
//  centerMarkerView.swift
//  Keep Recycle And Carry On
//
//  Created by Jessica Liu on 10/16/21.
//


import Foundation
import MapKit

class centerMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let center = newValue as? recycleCenters else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -10, y: 10)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

      // 2
      markerTintColor = center.markerTintColor
    }
  }
}
