//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Antonella Mariel Lesta on 14/04/2022.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
