//
//  AppDelegate.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configuración de Firebase
        FirebaseApp.configure()
        
        // Otras configuraciones iniciales pueden ir aquí
        
        return true
    }
    
    // Los siguientes métodos se utilizan para manejar transiciones de estado de la aplicación y otros eventos globales.
    // Puedes agregar o eliminar estos métodos según las necesidades de tu aplicación.
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Invocado cuando la aplicación está a punto de pasar del estado activo al inactivo.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Se usa para liberar recursos, guardar datos, invalidar timers, etc.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Llamado como parte de la transición del fondo al estado activo.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Reinicia cualquier tarea que se pausó mientras la aplicación estaba inactiva.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Llamado cuando la aplicación está a punto de terminar.
    }
}

