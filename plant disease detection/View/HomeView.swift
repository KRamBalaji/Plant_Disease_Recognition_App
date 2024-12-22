//
//  SwiftUIView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 02/09/22.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink(destination: CardDetailView(article: Article(title: "Organic farming in India: a vision towards a healthy nation", author: "Sri Ram", description: "Food quality and safety are the two important factors that have gained ever-increasing attention in general consumers.", image: "developer"))) {
                    CardView(article: Article(title: "Organic farming in India: a vision towards a healthy nation", author: "Sri Ram", description: "Food quality and safety are the two important factors that have gained ever-increasing attention in general consumers.", image: "developer"))
                        .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
