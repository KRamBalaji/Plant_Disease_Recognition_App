//
//  ProfileView.swift
//  plant disease detection
//
//  Created by Ram Balaji Koppula on 13/11/22.
//

import SwiftUI
import SafariServices

struct ProfileView: View {
    
    @AppStorage("needPrivacy") var needPrivacy: Bool = false
    
    @State private var link: WebLink?
    
    enum WebLink: String, Identifiable {
        
        case rateUs = "itms-apps://?action=today&referrer=app-store&itscg=10000&itsct=app-appstore-nav-200917"
        case feedback = "https://rambalaji.in/contact-us"
        case github = "https://github.com/KRamBalaji"
        case linkedin = "https://www.linkedin.com/in/krambalaji"
        case instagram = "https://www.instagram.com/k_rambalaji"
        
        var id: UUID {
            UUID()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    LottieView(lottieFile: "35269-the-guy-with-the-cat-at-the-computer")
                        .frame(width: 500, height: 300)
                        .padding()
                    Text("Made by Ram Balaji ©")
                    Section {
                        Link(destination: URL(string: WebLink.rateUs.rawValue)!, label: {
                                Label("Rate us on App Store", image: "store")
                                    .foregroundColor(.primary)
                        })
                        Label("Tell us your feedback", image: "chat")
                            .onTapGesture {
                                link = .feedback
                            }
                        
                    }
                    Section {
                        Link(destination: URL(string: WebLink.linkedin.rawValue)!, label: {
                                Label("LinkedIn", image: "linkedin")
                                    .foregroundColor(.primary)
                        })
                        Label("Github", image: "facebook")
                            .onTapGesture {
                                link = .github
                            }
                        Link(destination: URL(string: WebLink.instagram.rawValue)!, label: {
                                Label("Instagram", image: "instagram")
                                    .foregroundColor(.primary)
                        })
                    }
                    Button(action: {
                        needPrivacy = !needPrivacy
                    }) {
                        HStack {
                            Image(systemName: needPrivacy ? "lock.open" : "lock")
                            Text(needPrivacy ? "Unlock your app" : "Lock your app")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.black))
                        .shadow(color: .gray, radius: 2, x: -3, y: 5)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("About")
                .navigationBarTitleDisplayMode(.automatic)
                .fullScreenCover(item: $link) { item in
                    if let url = URL(string: item.rawValue) {
                        SafariView(url: url)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct SafariView: UIViewControllerRepresentable {
    var url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController , context: Context) {
        
    }
}
