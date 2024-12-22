//
//  ContentView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 27/08/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough: Bool = false
    @State private var showWalkthrough = false
    
    var body: some View {
        TabView{
            HomeView()
                .sheet(isPresented: $showWalkthrough) {
                    TutorialView()
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .onAppear() {
                    showWalkthrough = hasViewedWalkthrough ? false : true
                }
            UploadImageView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Classify")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "tray")
                    Text("About")
                }
        }
        //.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .accentColor(.teal)
    }
}
