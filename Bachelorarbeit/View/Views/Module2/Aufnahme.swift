//
//  Aufnahme&Verbindung.swift
//  Bachelorarbeit
//
//  Created by JT X on 10.12.20.
//


// Aufnahme + Nachrichtsenden
import SwiftUI
import MultipeerConnectivity

struct AufnahmeUI: View{
    
    @EnvironmentObject var nearbyService: NearbyService
    @EnvironmentObject var audioRecorder: AudioRecorder
//    @EnvironmentObject var userData: UserData
    @Binding var selectedTab: Int

    @State var profiles: [Profile]?
    @State var navTitle  = "AudioRecorder"
    @State var state: MCSessionState?
    @State var timeInfo: [String:String] = [:]

    
    @State private var showingAlert = false

//    func getAudioUrl()-> URL {
//        guard let filePathFive = Bundle.main .path(forResource: "testAudio", ofType: "wav") else { return URL.init(fileURLWithPath: "") }
//        return URL.init(fileURLWithPath: filePathFive)
//    }
    var body: some View {
        
       // var array = [nearbyService.peerID]
        //        NavigationView{
        VStack{
            Participants(audioRecorder: audioRecorder)
//            Text("\(nearbyService.connectedNames.debugDescription)")
            
            if audioRecorder.recording == false {
                Button(action:{
                    if self.nearbyService.isBrowser {
                       
//                        self.audioRecorder.isMeetingPreparation = true
                        self.nearbyService.send(msg: "Meeting Preparation")
                        self.timeInfo["sendMeetingTime"] = Date().milliStamp
                        
//                        if self.audioRecorder.isMeetingPreparation {
//                            self.audioRecorder.isMeetingPreparation = false
                            self.audioRecorder.startRecording()
                            navTitle = "Recording..."
                            self.timeInfo["startRecordingTime"] = Date().milliStamp
//                        }
//                        self.audioRecorder.play(getAudioUrl())
                        
                        
//                        self.audioRecorder.playEndBlock = {
//                            if self.audioRecorder.isMeetingPreparation {
//                                self.audioRecorder.isMeetingPreparation = false
//                                self.audioRecorder.startRecording()
//                                self.timeInfo["startRecordingTime"] = Date().milliStamp
//                                navTitle = "Recording..."
//                            }
//
//                        }
                        
                        // 导出完成
                        self.audioRecorder.exportCompletedBlock = {
                            self.showingAlert = false
                            self.selectedTab = 2
                        }
                        
                    }
                }){
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.red)
                        .frame(width: 100 , height: 100)
                        .clipped()
                        .overlay(Circle().stroke(Color.black , lineWidth: 4))
                        .padding(.bottom , 20)
                }
            }
            
            else {
                if self.nearbyService.isBrowser {
                HStack {
                    Button(action:{
                        audioRecorder.opsTimeIndex += 1
                        let opsTimeKey = "opsTime\(audioRecorder.opsTimeIndex)"
                        self.timeInfo[opsTimeKey] = Date().milliStamp
                    }){
                        Image(systemName:"xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 54 , height: 54)
                            .clipped()
                            .padding(20)
                    }
                    
                    Button(action:{
                        audioRecorder.importentTimeIndex += 1
                        let importentTimeKey = "importentTime\(audioRecorder.importentTimeIndex)"
                        self.timeInfo[importentTimeKey] = Date().milliStamp

                    }){
                        Image(systemName:"checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.green)
                            .frame(width: 54 , height: 54)
                            .clipped()
                            .padding(20)
                    }
                }
                }
                HStack {
                    if self.nearbyService.isBrowser {
                        Button(action:{
                            self.showingAlert = true
                            self.audioRecorder.stopRecording()
                            self.timeInfo["stopRecordingTime"] = Date().milliStamp
                            self.profiles?[0].timeInfo = self.timeInfo
                            navTitle  = "AudioRecorder"
                            self.nearbyService.send(msg: self.profiles.toJSONString())
                            let name = nearbyService.isBrowser ? nearbyService.sitzung.title : nearbyService.peerID.displayName

                            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                                do {
                                    try DataStorageManager().storeProfiles(profiles:self.profiles!, name: name)
                                } catch {
                                    print("End \(error)")
                                }
                            }
                        }){
                            Text("End")
                                .frame(width: 70 , height: 44)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                    
                    Button(action:{
                        if self.nearbyService.isBrowser {
                            self.audioRecorder.pauseRecording()
                            let pauseTimeKey = "\(audioRecorder.isPause ? "pauseTime" : "p_RecordingTime")\(audioRecorder.pauseIndex)"
                            self.timeInfo[pauseTimeKey] = Date().milliStamp

                            navTitle = audioRecorder.isPause ? "Pause..." : "Recording..."
                            
                        }
                    }){
                        Image(systemName: audioRecorder.isPause ? "pause.circle" : "record.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 100 , height: 100)
                            .clipped()
                            .overlay(Circle().stroke(Color.black , lineWidth: 4))
                            .padding(.bottom , 20)
                            .padding(.leading , audioRecorder.recording ? (self.nearbyService.isBrowser ? 20 : 90) : 0)
                            .padding(.trailing , audioRecorder.recording ? 20 : 0)
                        
                    }
                    
                    // mute function
                    
                    Button(action:{
                        self.audioRecorder.muteRecording()
                        navTitle = audioRecorder.isMute ? "You are muted" : "Recording..."
                    }){
                        Text(audioRecorder.isMute ? "unmute" : "mute")
                            .frame(width: 70 , height: 44)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    
                }
            }
        }
        .navigationBarTitle(navTitle,displayMode: .inline)
        .font(.callout)
        
        .onAppear{
            // only if participant accepted control
            audioRecorder.fetchRecordings()
            if !nearbyService.isBrowser {
                nearbyService.startAdvertising()
                self.state = MCSessionState(rawValue: 0)!
                navTitle = "waiting for connection..."
            }
            nearbyService.nearbyServiceDelegate = self
            self.profiles = [nearbyService.userData.profile]
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Exporting..."),
                  message: Text("Please wait a moment"))
        }
    }
}

extension AufnahmeUI:SuchenDelegate {
    func connectingState(state: MCSessionState) {
        self.state = state
        self.updateNavTitle(state: state)
        self.audioRecorder.updateOnlineState()
    }
    
    func updateNavTitle(state: MCSessionState) {
        switch state{
        case .connecting:
            navTitle = "connecting..."
            break
        case .connected:
            navTitle = "successfully connected"
            break
        case .notConnected:
            navTitle = "waiting for connection..."
            break
        @unknown default:
            print("unknown state:\(state)")
        }
    }
    
    func didReceiveFile(url: URL) {
        self.audioRecorder.fetchRecordings()
    }
    
    func didReceive(msg: String) {
        if msg == "start" {
            if self.audioRecorder.isPlay {
                self.audioRecorder.pasue()
            }
            self.audioRecorder.startRecording()
            self.timeInfo["startRecordingTime"] = Date().milliStamp
            navTitle = "Recording..."
            self.audioRecorder.exportCompletedBlock = {
                self.showingAlert = false
                self.selectedTab = 2
            }
            print("start recording")
        }else if msg == "stop" {
            print("stop recording")
            self.showingAlert = true
            self.audioRecorder.stopRecording()
            self.timeInfo["stopRecordingTime"] = Date().milliStamp
            nearbyService.userData.profile.timeInfo = self.timeInfo
            self.nearbyService.send(msg: nearbyService.userData.profile.toJSONString())

            self.profiles = [nearbyService.userData.profile]
            self.updateNavTitle(state: self.state!)
        }else if msg == "pause" {
            self.audioRecorder.pauseRecording()
            let pauseTimeKey = "pauseTime\(audioRecorder.pauseIndex)"
            self.timeInfo[pauseTimeKey] = Date().milliStamp

            navTitle = "Pause..."
        }else if msg == "record" {
            self.audioRecorder.pauseRecording()
            let pauseTimeKey = "p_Recording\(audioRecorder.pauseIndex)"
            self.timeInfo[pauseTimeKey] = Date().milliStamp

            navTitle = "Recording..."
        }else if msg == "Meeting Preparation" {
//            self.audioRecorder.play(getAudioUrl())
            self.timeInfo["receiveMeetingTime"] = Date().milliStamp
//            self.audioRecorder.startRecording()
//            navTitle = "Recording..."
//            self.timeInfo["startRecordingTime"] = Date().milliStamp
        }else {
            if self.nearbyService.isBrowser {
                guard let jsonData = msg.jSONStringToData() else {
                    return
                }
                
                if let profile = try? JSONDecoder().decode(Profile.self, from: jsonData) {
                    self.profiles?.append(profile)
                }
                
            }else {
                guard let jsonData = msg.jSONStringToData() else {
                    return
                }
                
                if let profiles = try? JSONDecoder().decode([Profile].self, from: jsonData) {
                    let name = nearbyService.isBrowser ? nearbyService.sitzung.title : nearbyService.peerID.displayName

                    do {
                        try DataStorageManager().storeProfiles(profiles:profiles,name:name)
                    } catch {
                        print("End \(error)")
                    }
                }
            }
        }
        
        print("didReceive \(msg)")
    }
    
}

//struct AufnahmeUI_Previews: PreviewProvider {
//    static var previews: some View {
//        AufnahmeUI().environmentObject(AudioRecorder(NearbyService(displayName: "",UserData())))
//    }
//}


