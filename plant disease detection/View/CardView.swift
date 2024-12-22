//
//  CardView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 15/11/22.
//

import SwiftUI

struct CardView: View {
    
    var article: Article
    
    var body: some View {
        VStack {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text("Written by \(article.author)".uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(article.description)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.4), lineWidth: 1))
        .padding([.top, .horizontal])
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(article: Article(title: "New way of Farming", author: "Ram Balaji", description: "Hello", image: "developer"))
    }
}
