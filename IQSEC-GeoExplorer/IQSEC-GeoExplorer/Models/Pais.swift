//
//  Pais.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation

struct Pais: Codable, Identifiable {
    var id: Int
    var nombre: String
}

class PaisParser: NSObject, XMLParserDelegate {
    var paises: [Pais] = []
    var currentElement = ""
    var currentIdPais = ""
    var currentNombrePais = ""

    func parsePaises(data: Data) -> [Pais] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return paises
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName
        if elementName == "Pais" {
            currentIdPais = ""
            currentNombrePais = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            switch currentElement {
            case "idPais": currentIdPais += data
            case "NombrePais": currentNombrePais += data
            default: break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Pais", let id = Int(currentIdPais) {
            let pais = Pais(id: id, nombre: currentNombrePais)
            paises.append(pais)
        }
    }
}
