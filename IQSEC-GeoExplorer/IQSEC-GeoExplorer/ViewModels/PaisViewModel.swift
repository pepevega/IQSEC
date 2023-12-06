//
//  PaisViewModel.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation

class PaisViewModel: ObservableObject {
    @Published var paises: [Pais] = []
    @Published var errorMessage: String?
    private var soapService = SoapService()

    init() {
        getPaises()
    }

    func getPaises() {
        soapService.getPaises { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let paises):
                    self?.paises = paises
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
}

