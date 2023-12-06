//
//  NetworkManager.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import Foundation
import Network

class NetworkManager {
    static let shared = NetworkManager()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func checkConnection() -> Bool {
        return isConnected
    }
}
