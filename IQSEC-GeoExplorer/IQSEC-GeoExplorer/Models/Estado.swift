//
//  Estado.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation
import CoreLocation

struct Estado: Identifiable {
    var id: Int
    var nombre: String
    var coordenadas: String
    
    var coordinate: CLLocationCoordinate2D {
            let parts = coordenadas.split(separator: ",").compactMap { Double($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
            if parts.count == 2 {
                return CLLocationCoordinate2D(latitude: parts[0], longitude: parts[1])
            } else {
                return CLLocationCoordinate2D()
            }
        }
}

class EstadosParser: NSObject, XMLParserDelegate {
    var estados: [Estado] = []
    var currentElement = ""
    var currentIdEstado = ""
    var currentEstadoNombre = ""
    var currentCoordenadas = ""

    func parseEstados(data: Data) -> [Estado] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return estados
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "Estado" {
            currentIdEstado = ""
            currentEstadoNombre = ""
            currentCoordenadas = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            switch currentElement {
            case "idEstado": currentIdEstado += data
            case "EstadoNombre": currentEstadoNombre += data
            case "Coordenadas": currentCoordenadas += data
            default: break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Estado", let id = Int(currentIdEstado) {
            let estado = Estado(id: id, nombre: currentEstadoNombre, coordenadas: currentCoordenadas)
            estados.append(estado)
        }
    }
}



