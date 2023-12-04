//
//  PlayerView.swift
//  Music
//
//  Created by Brandon LeBlanc on 12/2/23.
//

import SwiftUI

struct PlayerView: View {
    let file = "Instrumental"
    
    @EnvironmentObject var audio: Audio
    var slowerVM: SlowerViewModel
    var isPreview: Bool = false
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
//    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let g = geometry.size
            let sE = geometry.safeAreaInsets
            
            ZStack {
                Rectangle()
//                    .fill(Color.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                        Image("trees")
                            .blur(radius: 65)
                    })
                
                VStack(spacing: 10) {
                    GeometryReader {
                        let g = $0.size
                        Image("person")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: g.width, height: g.height)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    .frame(height: g.width - 50)
                    .padding(.vertical, g.height < 689 ? 11 : 31)
                    
                    if let player = audio.player {
                        
                        VStack(spacing: 5) {
                            
                            Text(slowerVM.slower.title)
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            Slider(value: $audio.playbackSpeed, in: 0.5...2.0, step: 0.1)
                                .padding()
                                .onTapGesture(count: 2) {
                                    audio.playbackSpeed = 1.0 // Set your default value here
                                }
                            
                            Text("Playback Speed: \(String(format: "%.2f", audio.playbackSpeed))x")
                                   .foregroundColor(.white)
                                   .padding(.bottom)
                            
                            HStack {
                                Slider(value: $value, in: 0...player.duration, onEditingChanged: { editing in
                                    print("editing", editing)
                                    isEditing = editing
                                    
                                    if !editing {
                                        player.currentTime = value
                                    }
                                })
                                
                                Button{
                                    
                                }label: {
                                    Image(systemName: "airpodspro.chargingcase.wireless.fill")
                                        .font(.title2)
                                    
                            }
                                .foregroundColor(.white)
                            }
                        }
                        
                        HStack {
                            Text(audio.timeString(time: player.currentTime))
                                .foregroundColor(.white)
                            Spacer()
                            Text("2:42")
                                .foregroundColor(.white)
                        }
                        
                        
                        HStack(spacing: g.width * 0.16) {
                            Button {
                                player.currentTime -= 10
                            } label: {
                                Image(systemName: "backward.fill")
                                    .font(g.height < 352 ? .title3 : .title)
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                                    .font(g.height < 352 ? .largeTitle : .system(size: 51))
                                    .onTapGesture {
                                        player.isPlaying ? audio.pause() : audio.play()
                                    }
                            }
                            
                            Button {
                                player.currentTime += 10
                            } label: {
                                Image(systemName: "forward.fill")
                                    .font(g.height < 352 ? .title3 : .title)
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        
//                        HStack {
//                            Button{
//                                
//                            }label: {
//                                Image(systemName: "airpodspro.chargingcase.wireless.fill")
//                                    .font(.title2)
//                                
//                        }
//                        }
//                        .foregroundColor(.white)
                    } else {
                        Text("No file")
                    }
                }
                .padding(.top, sE.top + (sE.bottom == 0 ? 11 : 0))
                .padding(.bottom, sE.bottom == 0 ? 11 : sE.bottom)
                .padding(.horizontal, 22)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .ignoresSafeArea(.container, edges: .all)
        }
        .onAppear {
            audio.startPlayer(track: slowerVM.slower.track,
                    isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audio.player, !isEditing else { return }
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let slowerVM = SlowerViewModel(slower: Slower.data)
    
    static var previews: some View {
        PlayerView(slowerVM: slowerVM, isPreview: true)
            .environmentObject(Audio())
//            .preferredColorScheme(.dark)
    }
}
