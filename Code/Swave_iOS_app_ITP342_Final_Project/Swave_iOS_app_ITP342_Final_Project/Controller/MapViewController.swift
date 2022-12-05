//
//  MapViewController.swift
//  Swave_iOS_app_ITP342_Final_Project
//
//  Created by Todd Gavin on 12/5/22.
//

import UIKit
import MapKit
import CoreLocation

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var image: UIImage

    init(coordinate: CLLocationCoordinate2D, image: UIImage) {
        self.coordinate = coordinate
        self.image = image
    }
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var latOutlet: UILabel!
    @IBOutlet weak var longOutlet: UILabel!
    
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    var locationManager: CLLocationManager!
//    let mapView = MKMapView()

    override func viewDidLoad() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        print("\(#function) Map View page")
    }
    
    
    @IBAction func backClickedAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(#function)")
        if let currentLocation = locations.last {
            let lat = currentLocation.coordinate.latitude
            let long = currentLocation.coordinate.longitude
            let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
            mapViewOutlet.setCenter(center, animated: true)
            print("Center: \(center)")
            latOutlet.text = String(lat)
            longOutlet.text = String(long)
            let annotation = MyAnnotation(coordinate: center, image: UIImage(named: "MapKitAnnotation")!)
            mapViewOutlet.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("\(#function)")
        if annotation is MKUserLocation {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
            annotationView.image = UIImage(named: "MapKit Annotation")
            return annotationView
        }
        return nil
    }
}

