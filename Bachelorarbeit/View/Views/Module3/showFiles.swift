//
//  showFiles.swift
//  Bachelorarbeit
//
//  Created by JT X on 05.08.22.
//


import SwiftUI

struct showFiles: View {
    @EnvironmentObject var audioRecorder: AudioRecorder
    var body: some View {
        VStack{
            
            HStack{
                /*
                Text("AudioURL")
                Button(action: {
                    
                }, label: {
                    Image(systemName:  "play")
                        //.resizable()
                       // .aspectRatio(contentMode: .fit)
                      //  .frame(width: 20, height: 20)
          
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName:  "square.and.arrow.up")
                        //.resizable()
                       // .aspectRatio(contentMode: .fit)
                      //  .frame(width: 20, height: 20)
          
                })
                */
                
                
            }
            Spacer()
            RecordingList(audioRecorder: audioRecorder)

        }.onAppear{
            // only if participant accepted control
            audioRecorder.fetchRecordings()
        }
    }
}

struct showFiles_Previews: PreviewProvider {
    static var previews: some View {
        showFiles()//.environmentObject(AudioRecorder(NearbyService(displayName: "",UserData())))
    }
}
