//
//  EstadoViewModel.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation

class EstadoViewModel: ObservableObject {
    @Published var estados: [Estado] = []
    @Published var errorMessage: String?
    private var soapService = SoapService()

    func getEstados(paisId: Int) {
        soapService.getEstadosbyPais(idPais: paisId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let estados):
                    self?.estados = estados
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
}

