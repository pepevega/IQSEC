//
//  SoapService.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation

class SoapService {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func performRequest(with url: URL, soapBody: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(String(soapBody.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = soapBody.data(using: .utf8)
        
        let task = session.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func getPaises(completion: @escaping (Result<[Pais], Error>) -> Void) {
        let soapBody = """
        <?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
          <soap:Body>
            <GetPaises xmlns="http://tempuri.org/" />
          </soap:Body>
        </soap:Envelope>
        """
        
        guard let url = URL(string: "https://servicesoap.azurewebsites.net/ws/Paises.asmx") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        performRequest(with: url, soapBody: soapBody) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotParseResponse)))
                return
            }
            
            // Procesamiento de la respuesta SOAP
            let parser = PaisParser()
            let paises = parser.parsePaises(data: data)
            completion(.success(paises))
        }
        
    }
    
    func getEstadosbyPais(idPais: Int, completion: @escaping (Result<[Estado], Error>) -> Void) {
        let soapBody = """
            <?xml version="1.0" encoding="utf-8"?>
            <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
              <soap:Body>
                <GetEstadosbyPais xmlns="http://tempuri.org/">
                  <idEstado>\(idPais)</idEstado>
                </GetEstadosbyPais>
              </soap:Body>
            </soap:Envelope>
            """
            
            guard let url = URL(string: "https://servicesoap.azurewebsites.net/ws/Paises.asmx") else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            performRequest(with: url, soapBody: soapBody) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(URLError(.cannotParseResponse)))
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                print("SOAP Response: \(responseString ?? "")")
                
                // Procesamiento de la respuesta SOAP
                let parser = EstadosParser()
                let estados = parser.parseEstados(data: data)
                
                completion(.success(estados))
            }
        }
}


