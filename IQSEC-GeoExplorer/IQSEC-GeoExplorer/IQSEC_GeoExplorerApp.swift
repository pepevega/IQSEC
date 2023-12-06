//
//  IQSEC_GeoExplorerApp.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import SwiftUI

@main
struct IQSEC_GeoExplorerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ListaPaisesView(viewModel: PaisViewModel())
        }
    }
}
