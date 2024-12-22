//
//  CardDetailView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 16/11/22.
//

import SwiftUI

struct CardDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack {
                Image(article.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay {
                        VStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(article.title)
                                    .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                                    .bold()
                                Text(article.author)
                                    .font(.system(.headline, design: .rounded))
                                    .padding(.all, 5)
                                    .background(Color.black)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                            .foregroundColor(.white)
                            .padding()
                        }
                    }
                Text(article.description)
                    .padding()
            }
        }
        .ignoresSafeArea()
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(article: Article(title: "Organic farming in India: a vision towards a healthy nation", author: "Ram Balaji", description: "Food quality and safety are the two important factors that have gained ever-increasing attention in general consumers.", image: "developer"))
    }
}
