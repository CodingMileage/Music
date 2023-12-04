//
//  ContentView.swift
//  Music
//
//  Created by Brandon LeBlanc on 11/27/23.
//

import SwiftUI
import AVKit

struct ContentView: View {
    
    var body: some View {
        ZStack {
            
//            Image("person")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//                .blur(radius: 3.0)
            
            NavigationView {
                VStack {
                    NavigationLink(destination: PlayerView(slowerVM: SlowerViewModel(slower: Slower.data)).environmentObject(Audio())) {
                        Text("Instrumental One")
                            .font(.title)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: PlayerView(slowerVM: SlowerViewModel(slower: Slower.data)).environmentObject(Audio())) {
                        Text("Instrumental Two")
                            .font(.title)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .navigationBarTitle("Music World")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
