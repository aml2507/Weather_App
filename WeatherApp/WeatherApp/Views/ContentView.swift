//
//  ContentView.swift
//  WeatherApp
//
//  Created by Antonella Mariel Lesta on 14/04/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            //if we don't have location, then we don't display coordinates
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                
                            } catch {
                                print("Error gettin weather:\(error)")
                            }
                        }
                }
                Text("Your coordinates are:\(location.longitude),\(location.latitude)")
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.609, saturation: 0.871, brightness: 0.305))
        .preferredColorScheme(.dark)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
