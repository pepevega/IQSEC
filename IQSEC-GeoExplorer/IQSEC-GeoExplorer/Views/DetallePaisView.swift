//
//  DetallePaisView.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import SwiftUI
import MapKit

struct DetallePaisView: View {
    @ObservedObject var viewModel: EstadoViewModel
    var paisId: Int
    var paisName: String
    @State private var selectedEstado: Estado?
    @State private var showingAlert = false
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.0, longitude: -103.0),
        span: MKCoordinateSpan(latitudeDelta: 37.0, longitudeDelta: 37.0)
    )

    var body: some View {
        VStack {
            MapView(region: $mapRegion, estados: viewModel.estados, selectedEstado: $selectedEstado, showingAlert: $showingAlert)
            List(viewModel.estados) { estado in
                Button(estado.nombre) {
                    withAnimation {
                        mapRegion = MKCoordinateRegion(
                            center: estado.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
                        )
                    }
                    selectedEstado = estado
                    showingAlert = true
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Información del Estado"),
                message: Text("País: \(paisName)\n" +
                               "Estado: \(selectedEstado?.nombre ?? "Desconocido")\n" +
                               "Coordenadas: \(selectedEstado?.coordinate.latitude ?? 0), \(selectedEstado?.coordinate.longitude ?? 0)"),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationBarTitle("Estados de \(paisName)")
        .onAppear {
            viewModel.getEstados(paisId: paisId)
        }
    }
}

//#Preview {
//    DetallePaisView()
//}
