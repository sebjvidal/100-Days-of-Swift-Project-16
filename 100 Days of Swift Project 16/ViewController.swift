//
//  ViewController.swift
//  100 Days of Swift Project 16
//
//  Created by Seb Vidal on 22/12/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupMapView()
        setupCapitals()
    }
    
    func setupNavBar() {
        title = "Capitals"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(changeMapType))
    
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    @objc func changeMapType() {
        let alertConroller = UIAlertController(title: nil, message: "Change Map Type", preferredStyle: .actionSheet)
        alertConroller.addAction(UIAlertAction(title: "Standard", style: .default, handler: setMapType))
        alertConroller.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: setMapType))
        alertConroller.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setMapType))
        alertConroller.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertConroller, animated: true)
    }
    
    func setMapType(_ action: UIAlertAction) -> Void {
        switch action.title {
        case "Standard":
            mapView.mapType = .standard
        case "Hybrid":
            mapView.mapType = .hybrid
        case "Satellite":
            mapView.mapType = .satellite
        default:
            return
        }
    }
    
    func setupMapView() {
        mapView.delegate = self
    }

    func setupCapitals() {
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", url: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", url: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", url: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", url: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", url: "https://en.wikipedia.org/wiki/Washington,_D.C.")
    
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {
            return nil
        }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .systemTeal

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {
            return
        }
        
        let detailViewController = DetailViewController()
        detailViewController.capital = capital
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

