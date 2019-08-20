//
//  ViewController.swift
//  GoogleMap
//
//  Created by Neeraj kumar on 16/07/19.
//  Copyright © 2019 prolifics. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject{
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}

class ViewController: UIViewController {

    var mapView: GMSMapView?
    var currentDestination: VacationDestination?
    let destination = [VacationDestination(name: "McDonal, Hydrebad", location: CLLocationCoordinate2DMake(17.450004, 78.382979), zoom: 15.0),VacationDestination(name: "Petrol", location: CLLocationCoordinate2DMake(17.461133, 78.385362), zoom: 18.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 17.4544439, longitude: 78.368384, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 17.448295, longitude: 78.379106)
        marker.title = "Hitech City,Hydrebad"
        marker.snippet = "India"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextLocation))

    }
    
    @objc func nextLocation(){
        if currentDestination == nil{
            currentDestination = destination.first
        }else{
            if let index = destination.index(of: currentDestination!){
                currentDestination = destination[index + 1]
            }
        }
        setMapCamera()
       
    }
    
    private func setMapCamera(){
        CATransaction.begin()
        CATransaction.setValue(10, forKey: kCATransactionAnimationDuration)
        mapView!.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        //            mapView?.camera = GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom)
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }
    
}
