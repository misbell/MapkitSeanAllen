//
//  ContentView.swift
//  Mapkit Sean Allen
//
//  Created by Michael Prenez-Isbell on 10/11/23.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.89105), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        
        Map(initialPosition: .region(region)) 
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear() {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

#Preview {
    ContentView()
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if  CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("show an alert letting them know this is off and to go turn it on")
            
        }
    }
    
private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            print("restricted likely due to parental controls")
            break
        case .denied:
            print("you have denied this app location services, go into settings to change it")
            break
        case .authorizedAlways, .authorizedWhenInUse:
            
            break
        @unknown default:
            // unknown attribute because
            // new cases may be added in the future
            // this is a non-frozen enum
            // frozen enums have the @frozen attribute
            // you don't need to check for unknown
            // future cases, there won't be any.
            // probably. :-)
             
            break
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
 //     < # placeholder text # >
        
        checkLocationAuthorization()
    }
    
}


