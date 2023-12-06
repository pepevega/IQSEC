//
//  ListaPaisesView.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import SwiftUI

struct ListaPaisesView: View {
    @ObservedObject var viewModel: PaisViewModel

    var body: some View {
        NavigationView {
            List(viewModel.paises) { pais in
                NavigationLink(destination: DetallePaisView(viewModel: EstadoViewModel(), paisId: pais.id, paisName: pais.nombre)) {
                    Text(pais.nombre)
                }
            }
            .navigationBarTitle("Países")
            .onAppear {
                viewModel.getPaises()
            }
        }
    }
}


//#Preview {
//    ListaPaisesView()
//}
