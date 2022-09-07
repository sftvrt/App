//
//  RecordingRow.swift
//  AudioRecorder
//
//   Created by JT X on 16.11.20.
//
//

import SwiftUI

struct RecordingRow: View {
    var audioURL: URL
    @EnvironmentObject var audioPlayer: AudioRecorder
    @Binding var url: URL?
    
    init(audioURL: URL , currentUrl: Binding<URL?>) {
        self.audioURL = audioURL
        self._url = currentUrl
    }
    
    var body: some View {
        HStack{
        VStack {
            Text("\(audioURL.lastPathComponent)")
        }
        Button(action: {
            if audioPlayer.asset?.url == audioURL && audioPlayer.isPlay {
                audioPlayer.pasue()
            } else {
                audioPlayer.play(audioURL)
            }
        }, label: {
            Image(systemName: (audioPlayer.asset?.url == audioURL && audioPlayer.isPlay) ? "pause" : "play")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
  
        })
    }
    }
 /*   func actionSheet() {
        guard let data = URL(string: "file:///\(audioURL.path)") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }*/
    
    
    
    
    struct RecordingRow_Previews: PreviewProvider {
        static var previews: some View {
            /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
        }
    }
}
