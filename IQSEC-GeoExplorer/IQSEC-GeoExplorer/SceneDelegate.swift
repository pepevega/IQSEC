//
//  SceneDelegate.swift
//  IQSEC-GeoExplorer
//
//  Created by Héctor Hernández on 05/12/23.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Crear la vista que será la raíz de tu jerarquía de vistas.
        let contentView = ContentView()

        // Usar un UIWindowScene para crear y configurar la ventana
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            // Configurar la vista raíz de la ventana con tu vista de contenido
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // Los siguientes métodos manejan la configuración del ciclo de vida de la escena.
    // Puedes agregar o eliminar estos métodos según las necesidades de tu aplicación.
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Llamado cuando la escena se desconecta de la app.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Reinicia las tareas que se pausaron o no se iniciaron cuando la escena estaba inactiva.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Pausar tareas en curso, deshabilitar temporizadores, etc.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Llamado como parte de la transición del fondo al estado activo.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Guardar datos, liberar recursos compartidos, etc.
    }
}

