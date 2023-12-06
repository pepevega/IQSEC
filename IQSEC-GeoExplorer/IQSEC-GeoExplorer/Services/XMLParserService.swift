//
//  XMLParserService.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation

class XMLParserService {
    func parsePaises(data: Data) -> Result<[Pais], Error> {
        var paises: [Pais] = []
        
        return .success(paises)
    }
    
}

