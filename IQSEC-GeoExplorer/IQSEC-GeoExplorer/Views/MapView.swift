//
//  MapView.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import SwiftUI
import MapKit
import FirebaseCrashlytics

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    var estados: [Estado]
    @Binding var selectedEstado: Estado?
    @Binding var showingAlert: Bool

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: estados) { estado in
            MapAnnotation(coordinate: estado.coordinate) {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        let attributes: [String: Any] = [
                            "latitude": estado.coordinate.latitude,
                            "longitude": estado.coordinate.longitude
                        ]
                        Crashlytics.crashlytics().log("Seleccionar pin \(estado.nombre)")
                        Crashlytics.crashlytics().setCustomKeysAndValues(attributes)
                        
                        let error = NSError(domain: "com.Jose.IQSEC-GeoExplorer", code: 42, userInfo: attributes)
                        Crashlytics.crashlytics().record(error: error)
                        
                        selectedEstado = estado
                        showingAlert = true
                    }
            }
        }
    }
}


//import SwiftUI
//import MapKit
//
//struct MapView: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 31.0, longitude: -103.0),
//        span: MKCoordinateSpan(latitudeDelta: 37.0, longitudeDelta: 37.0)
//    )
//    var estados: [Estado]
//
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: estados) { estado in
//            MapMarker(coordinate: estado.coordinate, tint: .blue)
//        }
//    }
//}

//import SwiftUI
//import MapKit

//struct MapView: View {
//    // Estados Unidos
//    private let regionUSA = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.090240, longitude: -95.712891),
//        span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)
//    )
//
//    // México
//    private let regionMexico = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 23.634501, longitude: -102.552784),
//        span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
//    )
//
//    // Estado para controlar la región actual del mapa
//    @State private var currentRegion: MKCoordinateRegion
//
//    init(focusOnUSA: Bool) {
//        if focusOnUSA {
//            _currentRegion = State(initialValue: regionUSA)
//        } else {
//            _currentRegion = State(initialValue: regionMexico)
//        }
//    }
//
//    var body: some View {
//        Map(coordinateRegion: $currentRegion)
//        // Aquí puedes agregar más lógica o controles relacionados con el mapa
//    }
//}


//#Preview {
//    MapView()
//}
